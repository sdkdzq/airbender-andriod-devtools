// This code contains NVIDIA Confidential Information and is disclosed to you
// under a form of NVIDIA software license agreement provided separately to you.
//
// Notice
// NVIDIA Corporation and its licensors retain all intellectual property and
// proprietary rights in and to this software and related documentation and
// any modifications thereto. Any use, reproduction, disclosure, or
// distribution of this software and related documentation without an express
// license agreement from NVIDIA Corporation is strictly prohibited.
//
// ALL NVIDIA DESIGN SPECIFICATIONS, CODE ARE PROVIDED "AS IS.". NVIDIA MAKES
// NO WARRANTIES, EXPRESSED, IMPLIED, STATUTORY, OR OTHERWISE WITH RESPECT TO
// THE MATERIALS, AND EXPRESSLY DISCLAIMS ALL IMPLIED WARRANTIES OF NONINFRINGEMENT,
// MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.
//
// Information and code furnished is believed to be accurate and reliable.
// However, NVIDIA Corporation assumes no responsibility for the consequences of use of such
// information or for any infringement of patents or other rights of third parties that may
// result from its use. No license is granted by implication or otherwise under any patent
// or patent rights of NVIDIA Corporation. Details are subject to change without notice.
// This code supersedes and replaces all information previously supplied.
// NVIDIA Corporation products are not authorized for use as critical
// components in life support devices or systems without express written approval of
// NVIDIA Corporation.
//
// Copyright (c) 2008-2013 NVIDIA Corporation. All rights reserved.
// Copyright (c) 2004-2008 AGEIA Technologies, Inc. All rights reserved.
// Copyright (c) 2001-2004 NovodeX AG. All rights reserved.  

#include "SnippetVehicleCreate.h"
#include "SnippetVehicleTireFriction.h"
#include "SnippetVehicleRaycast.h"

void computeWheelCenterOffsets(const PxF32 wheelFrontZ, const PxF32 wheelRearZ, const PxVec3& chassisDims, const PxF32 wheelWidth, const PxF32 wheelRadius, PxVec3* wheelCentreOffsets)
{
	//chassisDims.z is the distance from the rear of the chassis to the front of the chassis.
	//The front has z = 0.5*chassisDims.z and the rear has z = -0.5*chassisDims.z.
	//Compute a position for the front wheel and the rear wheel along the z-axis.
	//Compute the separation between each wheel along the z-axis.
	const PxF32 numLeftWheels = 2;
	const PxF32 deltaZ = (wheelFrontZ - wheelRearZ)/(numLeftWheels-1.0f);
	//Set the outside of the left and right wheels to be flush with the chassis.
	//Set the top of the wheel to be just touching the underside of the chassis.
	//Set the rear-left/rear-right/front-left,front-right wheels.
	wheelCentreOffsets[0] = PxVec3((-chassisDims.x + wheelWidth)*0.5f, -(chassisDims.y/2 + wheelRadius), wheelRearZ + (numLeftWheels-1)*deltaZ);
	wheelCentreOffsets[1] = PxVec3((+chassisDims.x - wheelWidth)*0.5f, -(chassisDims.y/2 + wheelRadius), wheelRearZ + (numLeftWheels-1)*deltaZ);
	wheelCentreOffsets[2] = PxVec3((-chassisDims.x + wheelWidth)*0.5f, -(chassisDims.y/2 + wheelRadius), wheelRearZ + 0*deltaZ*0.5f);
	wheelCentreOffsets[3] = PxVec3((+chassisDims.x - wheelWidth)*0.5f, -(chassisDims.y/2 + wheelRadius), wheelRearZ + 0*deltaZ*0.5f);
}

PxVehicleNoDrive* createVehicleNoDrive(const VehicleDesc& vehicle4WDesc, PxPhysics* physics, PxCooking* cooking)
{
	const PxVec3 chassisDims = vehicle4WDesc.chassisDims;
	const PxF32 wheelWidth = vehicle4WDesc.wheelWidth;
	const PxF32 wheelRadius = vehicle4WDesc.wheelRadius;

	//Construct a physx actor with shapes for the chassis and wheels.
	//Set the rigid body mass, moment of inertia, and center of mass offset.
	PxRigidDynamic* vehActor = NULL;
	{
		//Construct a convex mesh for a cylindrical wheel.
		PxConvexMesh* wheelMesh = createWheelMesh(wheelWidth, wheelRadius, *physics, *cooking);
		//Assume all wheels are identical for simplicity.
		PxConvexMesh* wheelConvexMeshes[4];
		PxMaterial* wheelMaterials[4];

		//Set the meshes and materials for the driven wheels.
		for(PxU32 i = 0; i < 4; i++)
		{
			wheelConvexMeshes[i] = wheelMesh;
			wheelMaterials[i] = vehicle4WDesc.wheelMaterial;
		}

		//Chassis just has a single convex shape for simplicity.
		PxConvexMesh* chassisConvexMesh = createChassisMesh(chassisDims, *physics, *cooking);
		PxConvexMesh* chassisConvexMeshes[1] = {chassisConvexMesh};
		PxMaterial* chassisMaterials[1] = {vehicle4WDesc.chassisMaterial};

		//Rigid body data.
		PxVehicleChassisData rigidBodyData;
		rigidBodyData.mMOI = vehicle4WDesc.chassisMOI;
		rigidBodyData.mMass = vehicle4WDesc.chassisMass;
		rigidBodyData.mCMOffset = vehicle4WDesc.chassisCMOffset;

		vehActor = createVehicleActor
			(rigidBodyData,
			wheelMaterials, wheelConvexMeshes, 4,
			chassisMaterials, chassisConvexMeshes, 1,
			*physics);
	}

	//Set up the sim data for the wheels.
	PxVehicleWheelsSimData* wheelsSimData = PxVehicleWheelsSimData::allocate(4);
	{
		//Compute the wheel center offsets from the origin.
		PxVec3 wheelCentreOffsets[4];
		const PxF32 frontZ = chassisDims.z*0.3f;
		const PxF32 rearZ = -chassisDims.z*0.3f;
		computeWheelCenterOffsets(frontZ, rearZ, chassisDims, wheelWidth, wheelRadius, wheelCentreOffsets);

		//Set up the wheels.
		PxVehicleWheelData wheels[4];
		{
			//Set up the wheel data structures with mass, moi, radius, width.
			for(PxU32 i = 0; i < 4; i++)
			{
				wheels[i].mMass = vehicle4WDesc.wheelMass;
				wheels[i].mMOI = vehicle4WDesc.wheelMOI;
				wheels[i].mRadius = wheelRadius;
				wheels[i].mWidth = wheelWidth;
			}
		}

		//Set up the tires.
		PxVehicleTireData tires[4];
		{
			//Set up the tires.
			for(PxU32 i = 0; i < 4; i++)
			{
				tires[i].mType = TIRE_TYPE_NORMAL;
			}
		}

		//Set up the suspensions
		PxVehicleSuspensionData suspensions[4];
		{
			//Compute the mass supported by each suspension spring.
			PxF32 suspSprungMasses[4];
			PxVehicleComputeSprungMasses(4, wheelCentreOffsets, vehicle4WDesc.chassisCMOffset, vehicle4WDesc.chassisMass, 1, suspSprungMasses);

			//Set the suspension data.
			for(PxU32 i = 0; i < 4; i++)
			{
				suspensions[i].mMaxCompression = 0.3f;
				suspensions[i].mMaxDroop = 0.1f;
				suspensions[i].mSpringStrength = 35000.0f;	
				suspensions[i].mSpringDamperRate = 4500.0f;
				suspensions[i].mSprungMass = suspSprungMasses[i];
			}

			//Set the camber angles.
			const PxF32 camberAngleAtRest=0.0;
			const PxF32 camberAngleAtMaxDroop=0.01f;
			const PxF32 camberAngleAtMaxCompression=-0.01f;
			for(PxU32 i = 0; i < 4; i+=2)
			{
				suspensions[i + 0].mCamberAtRest =  camberAngleAtRest;
				suspensions[i + 1].mCamberAtRest =  -camberAngleAtRest;
				suspensions[i + 0].mCamberAtMaxDroop = camberAngleAtMaxDroop;
				suspensions[i + 1].mCamberAtMaxDroop = -camberAngleAtMaxDroop;
				suspensions[i + 0].mCamberAtMaxCompression = camberAngleAtMaxCompression;
				suspensions[i + 1].mCamberAtMaxCompression = -camberAngleAtMaxCompression;
			}
		}

		//Set up the wheel geometry.
		PxVec3 suspTravelDirections[4];
		PxVec3 wheelCentreCMOffsets[4];
		PxVec3 suspForceAppCMOffsets[4];
		PxVec3 tireForceAppCMOffsets[4];
		{
			//Set the geometry data.
			for(PxU32 i = 0; i < 4; i++)
			{
				//Vertical suspension travel.
				suspTravelDirections[i] = PxVec3(0,-1,0);

				//Wheel center offset is offset from rigid body center of mass.
				wheelCentreCMOffsets[i] = wheelCentreOffsets[i] - vehicle4WDesc.chassisCMOffset;

				//Suspension force application point 0.3 metres below rigid body center of mass.
				suspForceAppCMOffsets[i]=PxVec3(wheelCentreCMOffsets[i].x,-0.3f,wheelCentreCMOffsets[i].z);

				//Tire force application point 0.3 metres below rigid body center of mass.
				tireForceAppCMOffsets[i]=PxVec3(wheelCentreCMOffsets[i].x,-0.3f,wheelCentreCMOffsets[i].z);
			}
		}

		//Set up the filter data of the raycast that will be issued by each suspension.
		PxFilterData qryFilterData;
		setupNonDrivableSurface(qryFilterData);

		//Set the wheel, tire and suspension data.
		//Set the geometry data.
		//Set the query filter data
		for(PxU32 i = 0; i < 4; i++)
		{
			wheelsSimData->setWheelData(i, wheels[i]);
			wheelsSimData->setTireData(i, tires[i]);
			wheelsSimData->setSuspensionData(i, suspensions[i]);
			wheelsSimData->setSuspTravelDirection(i, suspTravelDirections[i]);
			wheelsSimData->setWheelCentreOffset(i, wheelCentreCMOffsets[i]);
			wheelsSimData->setSuspForceAppPointOffset(i, suspForceAppCMOffsets[i]);
			wheelsSimData->setTireForceAppPointOffset(i, tireForceAppCMOffsets[i]);
			wheelsSimData->setSceneQueryFilterData(i, qryFilterData);
			wheelsSimData->setWheelShapeMapping(i, i); 
		}
	}

	//Create a vehicle from the wheels and drive sim data.
	PxVehicleNoDrive* vehDriveNoDrive = PxVehicleNoDrive::allocate(4);
	vehDriveNoDrive->setup(physics, vehActor, *wheelsSimData);

	//Free the sim data because we don't need that any more.
	wheelsSimData->free();

	return vehDriveNoDrive;
}




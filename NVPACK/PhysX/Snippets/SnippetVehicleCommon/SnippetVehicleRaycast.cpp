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

#include <new>
#include "SnippetVehicleRaycast.h"
#include "PxPhysicsAPI.h"

using namespace physx;


void setupDrivableSurface(PxFilterData& filterData)
{
	filterData.word3 = (PxU32)DRIVABLE_SURFACE;
}

void setupNonDrivableSurface(PxFilterData& filterData)
{
	filterData.word3 = UNDRIVABLE_SURFACE;
}

PxQueryHitType::Enum WheelRaycastPreFilter
(PxFilterData filterData0, PxFilterData filterData1,
 const void* constantBlock, PxU32 constantBlockSize,
 PxHitFlags& queryFlags)
{
	//filterData0 is the vehicle suspension raycast.
	//filterData1 is the shape potentially hit by the raycast.
	PX_UNUSED(constantBlockSize);
	PX_UNUSED(constantBlock);
	PX_UNUSED(filterData0);
	PX_UNUSED(queryFlags);
	return ((0 == (filterData1.word3 & DRIVABLE_SURFACE)) ? PxQueryHitType::eNONE : PxQueryHitType::eBLOCK);
}

VehicleSceneQueryData::VehicleSceneQueryData()
{
	mPreFilterShader=WheelRaycastPreFilter;
	mSqResultsSize=0;
	mSqResults=NULL;
}

VehicleSceneQueryData::~VehicleSceneQueryData()
{
}

VehicleSceneQueryData* VehicleSceneQueryData::allocate(const PxU32 maxNumWheels, PxAllocatorCallback& allocator)
{
	const PxU32 size = sizeof(VehicleSceneQueryData) + sizeof(PxRaycastQueryResult)*maxNumWheels + sizeof(PxRaycastHit)*maxNumWheels;
	void* sqDataBuffer = allocator.allocate(size, NULL, NULL, 0);
	VehicleSceneQueryData* sqData = new(sqDataBuffer) VehicleSceneQueryData();
	PxU8* ptr = (PxU8*) sqData;
	ptr += sizeof(VehicleSceneQueryData);
	sqData->mSqResults = (PxRaycastQueryResult*)ptr;
	sqData->mSqResultsSize = maxNumWheels;
	ptr +=  sizeof(PxRaycastQueryResult)*maxNumWheels;
	sqData->mSqHitBuffer = (PxRaycastHit*)ptr;
	ptr += sizeof(PxRaycastHit)*maxNumWheels;
	sqData->mNumQueries = maxNumWheels;
	return sqData;
}

void VehicleSceneQueryData::free(PxAllocatorCallback& allocator)
{
	allocator.deallocate(this);
}

PxBatchQuery* VehicleSceneQueryData::setUpBatchedSceneQuery(PxScene* scene)
{
	PxBatchQueryDesc sqDesc(mSqResultsSize, 0, 0);
	sqDesc.queryMemory.userRaycastResultBuffer = mSqResults;
	sqDesc.queryMemory.userRaycastTouchBuffer = mSqHitBuffer;
	sqDesc.queryMemory.raycastTouchBufferSize = mNumQueries;
	sqDesc.preFilterShader = mPreFilterShader;
	return scene->createBatchQuery(sqDesc);
}


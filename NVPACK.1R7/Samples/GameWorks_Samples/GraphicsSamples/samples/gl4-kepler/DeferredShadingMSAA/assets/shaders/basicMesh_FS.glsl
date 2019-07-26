//----------------------------------------------------------------------------------
// File:        gl4-kepler\DeferredShadingMSAA\assets\shaders/basicMesh_FS.glsl
// SDK Version: v3.00 
// Email:       gameworks@nvidia.com
// Site:        http://developer.nvidia.com/
//
// Copyright (c) 2014-2015, NVIDIA CORPORATION. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//  * Neither the name of NVIDIA CORPORATION nor the names of its
//    contributors may be used to endorse or promote products derived
//    from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
// OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//----------------------------------------------------------------------------------
layout(location = 0) in vec4  inVertViewPosition;
layout(location = 1) in vec3  inWorldNormal;
layout(location = 2) in vec2  inUV;

layout(location = 0) out vec4 outNormalDepth;
layout(location = 1) out vec4 outDiffuseEdge;
layout(location = 2) out uint outCoverage;

const uint cMSAACount = 4;
uniform int uSampleMask;
uniform vec3 uDiffuseColor = vec3(1.0f, 1.0f, 1.0f);

void main(void)
{
    outNormalDepth.xyz = normalize(inWorldNormal);
    outNormalDepth.w = inVertViewPosition.z / 100.0;

    outDiffuseEdge.rgb = uDiffuseColor;
    outDiffuseEdge.a = (gl_SampleMaskIn[0] != uSampleMask) ? 1.0 : 0.0;

    // Max 32-bit MSAA
    outCoverage = (uSampleMask & gl_SampleMaskIn[0]);
}



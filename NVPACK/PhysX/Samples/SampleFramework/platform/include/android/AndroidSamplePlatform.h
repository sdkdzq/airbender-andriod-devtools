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

#ifndef ANDROID_SAMPLE_PLATFORM_H
#define ANDROID_SAMPLE_PLATFORM_H

#include <SamplePlatform.h>
#include <android/AndroidSampleUserInput.h>
#if defined(RENDERER_ANDROID)

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <EGL/egl.h>

/**
 * Shared state for our app.
 */
struct android_app;

struct engine
{
    struct android_app* app;
};

/* MojoShader tool converts shaders, this is structure
	to hold translation result and variables relocation information */

struct mojoResult
{
	struct shaderUniformRelocation
	{
		/* New uniform name. That is, for all uniforms that were of
		non-sampler2D type the name will be "vs_uniforms_vec4" or "ps_uniforms_vec4 (which means
		that all these such variables will be stored in the one uniform array),
		while for those which were of type sampler2D, their names will ps_sN, N = [0,1,2,...] */
		std::string		name;
		/* This is the starting index in the uniform array, in bytes */
		unsigned int 	index;
		/* This is the size of some relocated variable, in bytes */
		unsigned int 	size;
		/* This is the GL type of some original relocated variable */
		GLuint		 	type;
	};

	typedef std::map<std::string, shaderUniformRelocation> 		relocationType;
	typedef std::map<size_t, std::vector<std::string> >			attributesType;

	struct parseResultType
	{
		std::string 								source;
		mojoResult::attributesType					attributes;
	};

	parseResultType					parseResult;
	relocationType					relocation;
};


namespace SampleFramework
{
	class AndroidPlatform : public SamplePlatform
	{
	public:
		explicit							AndroidPlatform(SampleRenderer::RendererWindow* _app);
		virtual void						swapBuffers();
		virtual bool						preOpenWindow(void * ptr);
		virtual void						initializeOGLDisplay(const SampleRenderer::RendererDesc& desc,
																physx::PxU32& width,
																physx::PxU32& height);
		virtual void						setupRendererDescription(SampleRenderer::RendererDesc& renDesc);
		virtual void						freeDisplay();
		virtual bool						isOpen();
		virtual void						update();
		// Input
		virtual void						doInput();
		virtual void						showMessage(const char* title, const char* message);
		virtual void*						compileProgram(void * context,
															const char* assetDir,
															const char *programPath,
															physx::PxU64 profile,
															const char* passString,
															const char *entry,
															const char **args);
		/* This is for internal uses only. Do not call it from outside. It chould be called from non-member function, so it couldn't be private*/
		void								setWindowShown(bool);
		/* This is for internal uses only. Do not call it from outside. It chould be called from non-member function, so it couldn't be private*/
		void								setAndroidWindow(void *);
		/* This is for internal uses only. Do not call it from outside. It chould be called from non-member function, so it couldn't be private*/
		void								processScreenpads();
		/* This is for internal uses only. Do not call it from outside. It chould be called from non-member function, so it couldn't be private*/
		void								processScreenbuttons();
		/* return path separator for android */
		const char*							getPathSeparator();
		/* creates folders if necessary */
		bool								makeSureDirectoryPathExists(const char* dirPath);

		virtual const SampleUserInput*		getSampleUserInput() const { return &m_androidSampleUserInput; }
		virtual SampleUserInput*			getSampleUserInput() { return &m_androidSampleUserInput; }

		virtual const char*					getPlatformName() const { return m_platformName; }
	private:

		bool									m_windowShown;
		struct engine 							m_engine;
		struct android_app*						m_androidApp;
		void*									m_androidWindow;

		char									m_platformName[256];

		AndroidSampleUserInput					m_androidSampleUserInput;

		EGLDisplay								m_eglDisplay;
		EGLContext								m_eglContext;
		EGLSurface								m_eglSurface;
		EGLConfig								m_eglConfig;
	};
}

#endif
#endif

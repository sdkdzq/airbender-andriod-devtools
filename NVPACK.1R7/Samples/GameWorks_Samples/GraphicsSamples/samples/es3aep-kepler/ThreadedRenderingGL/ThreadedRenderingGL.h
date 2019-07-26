//----------------------------------------------------------------------------------
// File:        es3aep-kepler\ThreadedRenderingGL/ThreadedRenderingGL.h
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
#ifndef ThreadedRenderingGL_H_
#define ThreadedRenderingGL_H_
#include "NV/NvPlatformGL.h"
#include "NvAppBase/gl/NvSampleAppGL.h"

#include "NV/NvMath.h"
#include "NvAppBase/NvCPUTimer.h"
#include "NvUI/NvBitFont.h"

#include "NvGamepad/NvGamepad.h"
#include "NvGLUtils/NvTimers.h"

#include <vector>
#include "NvInstancedModelExtGL.h"
#include "NvMultiDrawModelSet.h"
#include "School.h"
#include <cstdlib>
#include <deque>
#include "SchoolStateManager.h"

#define CPU_TIMER_SCOPE(TIMER_ID) NvCPUTimerScope cpuTimer(&m_CPUTimers[TIMER_ID])
#define GPU_TIMER_SCOPE() NvGPUTimerScope gpuTimer(&m_GPUTimer)

class NvInputHandler_CameraFly;
class NvQuad;
class NvGLSLProgram;

class ThreadedRenderingGL : public NvSampleAppGL
{
public:
    ThreadedRenderingGL();
    virtual ~ThreadedRenderingGL();

    // Inherited methods
    virtual void configurationCallback(NvGLConfiguration& config);
    virtual void initRendering(void);
    virtual void initUI(void);
    virtual void reshape(int32_t width, int32_t height);
    virtual void draw(void);

    enum {
        MAX_ANIMATION_THREAD_COUNT = 8,
        THREAD_STACK_SIZE = 8192U
    };

    /// IDs for threads based on the work that they do and the
    /// numbers of that type of thread available
    enum
    {
        CPU_TIMER_MAIN_CMD_BUILD = 0,
        CPU_TIMER_MAIN_WAIT,
        CPU_TIMER_MAIN_COPYVBO,
        CPU_TIMER_THREAD_BASE_CMD_BUILD,
        CPU_TIMER_THREAD_MAX_CMD_BUILD = CPU_TIMER_THREAD_BASE_CMD_BUILD + MAX_ANIMATION_THREAD_COUNT,
        CPU_TIMER_THREAD_BASE_ANIMATE,
        CPU_TIMER_THREAD_MAX_ANIMATE = CPU_TIMER_THREAD_BASE_ANIMATE + MAX_ANIMATION_THREAD_COUNT,
        CPU_TIMER_THREAD_BASE_UPDATE,
        CPU_TIMER_THREAD_MAX_UPDATE = CPU_TIMER_THREAD_BASE_UPDATE + MAX_ANIMATION_THREAD_COUNT,
        CPU_TIMER_THREAD_BASE_TOTAL,
        CPU_TIMER_THREAD_MAX_TOTAL = CPU_TIMER_THREAD_BASE_TOTAL + MAX_ANIMATION_THREAD_COUNT,
        CPU_TIMER_COUNT
    };

    /// Values to identify the current "rendering mode" being used
    enum
    {
        TECHNIQUE_GLES_SUBRANGE = 0,
        TECHNIQUE_GLES_SUBRANGE_PERSISTENT,
        TECHNIQUE_GLES_ORPHANED,
        TECHNIQUE_GLES_POOLED,
        TECHNIQUE_GLES_POOLED_PERSISTENT,
        TECHNIQUE_GLAZDO_POOLED,
        TECHNIQUE_GLAZDO_POOLED_PERSISTENT,
        TECHNIQUE_COUNT
    };

    enum
    {
        RESET_RANDOM = 0,   // Schools will spawn at random locations
        RESET_ORIGIN,       // Schools will spawn at the center of the tank
        RESET_COUNT
    };

    /// Enum identifying the various versions of stats
    /// displayed in the app
    enum StatsMode
    {
        STATS_NONE = 0,
        STATS_SIMPLE,
        STATS_FULL,
        STATS_COUNT
    };

    /// Structure matching a Uniform Object in most shaders that contains
    /// the standard camera/projection matrices shared by most objects
    /// in the scene.
    struct ProjUBO
    {
        // Pipeline matrices
        nv::matrix4f m_projectionMatrix;
        nv::matrix4f m_inverseProjMatrix;
        nv::matrix4f m_viewMatrix;
        nv::matrix4f m_inverseViewMatrix;
    };

    /// Structure matching a Uniform Object in most shaders that contains
    /// the standard lighting values shared by most objects
    /// in the scene.
    struct LightingUBO
    {
        nv::vec4f m_lightPosition;
        nv::vec4f m_lightAmbient;
        nv::vec4f m_lightDiffuse;
        float m_causticOffset;
        float m_causticTiling;
    };

    /// Book-keeping structure holding data pertinent to a thread
    /// working on a school
    struct ThreadData {
        NvThread* m_thread;
        ThreadedRenderingGL* m_app;
        uint32_t m_index;
        bool m_cmdBufferOpen;
        uint32_t m_drawCallCount;
        uint32_t m_baseSchoolIndex;
        uint32_t m_schoolCount;
        uint32_t m_frameID; 
    };

    /// Worker function called by each animation thread to update 
    /// the flocking animation in the school(s) that it handles
    /// \param threadIndex Index of the thread calling the method
    void animateJobFunction(uint32_t threadIndex);

    /// Method to update the given school
    /// \param threadIndex Index of the thread calling the function
    /// \param schoolIndex Index of the school to update
    /// \parapm pSchool Pointer to the school to update
    void updateSchool(uint32_t threadIndex, uint32_t schoolIndex,
        School* pSchool);

private:
    // Additional rendering setup methods
    /// Shutdown and free all rendering resources
    void cleanRendering(void);

    /// Checks for availability of features required to take advantage
    /// of AZDO methodologies.
    void initAZDO();

    /// Switches rendering mode to AZDO enabled mode, if possible
    bool enableAZDO();

    /// Switches rendering mode to non-AZDO mode
    void disableAZDO();

    /// Resizes the School Descriptions array to the given size,
    /// initializing any new descriptions from the static array 
    /// of ms_schoolInfo data.
    /// \param numSchools New number of schools to contain descriptions for
    void initializeSchoolDescriptions(uint32_t numSchools);

    /// Sets the current method to use to manage VBOs used for instance data
    /// for the schools
    /// \param policy VBO managemetn policy to activate
    void setVBOPolicy(Nv::VBOPolicy policy);

    /// UI Input handler
    /// \param react UI Reaction to respond to
    /// \return Response code indicating whether the method handled the
    ///         reaction or whether it should be passed on
    virtual NvUIEventResponse handleReaction(const NvUIReaction &react);

    /// Gamepad input handler
    /// \param button Value indicating which controller button is being interacted with
    /// \param down Boolean indicating whether the button is being pressed or released
    /// \return True if the method handled the event, false if it did not handle it
    virtual bool handleGamepadButtonChanged(uint32_t button, bool down);

    /// Returns the current rendering mode as defined in TECHNIQUE_* enums
    uint32_t getCurrentRenderingTechnique();

    /// Updates the UI to match the current value of any variables tied to the UI
    void updateUI();

    /// Updates the visibility of the various logs displayed in the app
    void updateLogos();

    /// Gets the current frame time, clamping it if the frame rate gets too low
    /// \return Time elapsed in the processing of the current frame, in seconds.
    float getClampedFrameTime();

    /// Creates a texture usable by the UI system from the given file
    /// \param texFilename String representing the relative path to the texture file
    /// \return Pointer to an NvUIGraphic object that can be used to render
    ///         the texture with the UI system.
    NvUIGraphic* initLogoTexture(const char* texFilename);

    /// Moves each school to a random location (unless fishsplosion parameter is set
    /// to true, in which case all locations will be the center of the tank volume)
    /// and respawn all fish within their spawn range of the new location.
    /// \param fishsplosion Parameter indicating that all schools should be relocated
    ///                     to the center of the "tank" volume rather than random 
    ///                     locations within the volume.
    void resetFish(bool fishsplosion);

    // Methods that draw a specific scene component
    void drawSkyboxColorDepth();
    void drawGroundPlane();

    void renderScene();

    // Thread handling methods
    void initThreads(void);
    void cleanThreads(void);

    // Methods to affect the current settings of the app
    uint32_t setNumSchools(uint32_t numSchools);
    void updateSchoolTankSizes();
    uint32_t setAnimationThreadNum(uint32_t numThreads);

    /// Updates the stats displayed by the UI
    void updateStats();
   
    // Helper method for building up the string displayed by the simple stats UI
    // \param buffer Pointer to a character buffer to fill in with the string
    //               to use to fill in the stats UI
    // \param size Size of the passed buffer in number of characters including 
    //             the null terminator.
    void buildSimpleStatsString(char* buffer, int32_t size);

    // Helper method for building up the string displayed by the full stats UI
    // \param buffer Pointer to a character buffer to fill in with the string
    //               to use to fill in the stats UI
    // \param size Size of the passed buffer in number of characters including 
    //             the null terminator.
    void buildFullStatsString(char* buffer, int32_t size);

    // Array of stack objects used by the animation threads
    NVTHREAD_STACK_ALIGN char m_threadStacks[MAX_ANIMATION_THREAD_COUNT][THREAD_STACK_SIZE];
    
    // Flag indicating whether the camera is currently following a school
    bool m_bFollowingSchool;

    // Array of thread book-keeping structures for the animation threads
    ThreadData m_threads[MAX_ANIMATION_THREAD_COUNT];

    // Wrapper object to hold schools that need animated along with their index in the array of schools
    struct ThreadJob
    {
        School* m_school;
        uint32_t m_index;
    };

    // Mutex and condition variable to signal threads that a new frame is 
    // started and there's work to be done
    NvMutex* m_frameStartLock;
    NvConditionVariable* m_frameStartCV;

    // Queue containing entries for each school that needs to be updated.
    // (Only used if USE_STATIC_THREAD_WORK is not defined)
    std::deque<ThreadJob> m_needsUpdateQueue;

    // Mutex to control access to the queue so that only one thread will 
    // attempt to retrieve a block of work off of the update queue at a time
    // (Only used if USE_STATIC_THREAD_WORK is not defined)
    NvMutex* m_needsUpdateQueueLock;

    // Counter of the number of schools that have completed their update so that
    // a frame can continue its rendering once all schools are updated.
    uint32_t m_doneCount;

    // Mutex to synchronize access to the count of threads that have completed their work
    NvMutex* m_doneCountLock;

    // Condition variable to signal that more schools have been completed and that the
    // m_doneCount value has been modified.
    NvConditionVariable* m_doneCountCV;

    // Number of threads that will run each frame to update schools
    uint32_t m_activeThreads;
    
    // Number of frames we want to draw ahead.  Also used to tell the VBO
    // policies how many frames worth of buffer we will need.
    uint32_t m_numDrawAheadFrames;
    
    // Flag set at startup to indicate whether the system supports the
    // API level and extensions that we need to enable AZDO mode
    bool m_bAZDOAvailable;
    bool m_bAZDOEnabled;

    // Pointer to the object responsible for rendering the schools
    // using glMultiDrawElementsIndirect() if AZDO mode is enabled.
    Nv::NvMultiDrawModelSet* m_pMultiDrawModelSet;

    // Ring buffer of per-frame fences used limit the number of 
    // frames submitted for rendering before any previous frame
    // has completed rendering.  A fence will be created at the
    // current index (0 to m_numFrameFences-1) at the end of each
    // frame's rendering.  At the beginning of each frame, the
    // current index's fence is waited on before continuing.
    bool m_bEnableFences;
    GLsync* m_fences;
    uint32_t m_currentFenceIndex;

    bool m_running;

    NvInputHandler_CameraFly* m_pInputHandler;

    // Member fields that hold shader objects
    NvGLSLProgram* m_shader_GroundPlane;
    NvGLSLProgram* m_shader_Skybox;
    NvGLSLProgram* m_shader_Fish;
    NvGLSLProgram* m_shader_MultiDrawFish; // Only used in AZDO mode

    // Member fields that hold the scene geometry
    // Enum giving identifiers for all Fish models available for use
    enum
    {
        MODEL_BLACK_WHITE_FISH,
        MODEL_BLUE_FISH,
        MODEL_BLUE_FISH_02,
        MODEL_BLUE_FISH_03,
        MODEL_BLUE_FISH_04,
        MODEL_BLUE_FISH_05,
        MODEL_BLUE_FISH_06,
        MODEL_BLUE_FISH_07,
        MODEL_BLUE_FISH_08,
        MODEL_BLUE_FISH_09,
        MODEL_CYAN_FISH,
        MODEL_PINK_FISH,
        MODEL_RED_FISH,
        MODEL_VIOLET_FISH,
        MODEL_YELLOW_FISH,
        MODEL_YELLOW_FISH_02,
        MODEL_YELLOW_FISH_03,
        MODEL_YELLOW_FISH_04,
        MODEL_YELLOW_FISH_05,
        MODEL_YELLOW_FISH_06,
        MODEL_YELLOW_FISH_07,
        MODEL_YELLOW_FISH_08,
        MODEL_YELLOW_FISH_09,
        MODEL_YELLOW_FISH_10,
        MODEL_YELLOW_FISH_11,
        MODEL_COUNT
    };

    /// Uniform buffer object providing per-scene projection parameters to the shader
    ProjUBO m_projUBO_Data;       // Actual values for the UBO
    GLuint  m_projUBO_Id;         // UBO Id
    GLint   m_projUBO_Location;   // Uniform Index

    /// Uniform buffer object providing per-scene lighting parameters to the shader
    LightingUBO m_lightingUBO_Data;       // Actual values for the UBO
    GLuint      m_lightingUBO_Id;         // UBO Id
    GLint       m_lightingUBO_Location;   // Uniform Index

    // define the volume that the fish will remain within
    static nv::vec3f ms_tankMin;
    static nv::vec3f ms_tankMax;
    nv::vec3f m_startingCameraPosition;
    nv::vec2f m_startingCameraPitchYaw;

    static inline nv::vec3f Rotate(const nv::matrix4f& m, const nv::vec3f& n)
    {
        nv::vec3f r;
        r.x = n.x * m._11 + n.y * m._21 + n.z * m._31;
        r.y = n.x * m._12 + n.y * m._22 + n.z * m._32;
        r.z = n.x * m._13 + n.y * m._23 + n.z * m._33;
        return r;
    }

    // Structure describing a fish model that will
    // be loaded by the application
    struct ModelDesc
    {
        const char* m_name;         // Basic name of the model
        const char* m_filename;     // Filename of the model to load
        nv::matrix4f m_fixupXfm;    // Transform to rotate the model from its
                                    // authored space to the application's
                                    // coordinate system.
        nv::vec3f m_halfExtents;    // Vector from the center to the maximum
                                    // corner of a bounding box containing the
                                    // model in the application's coordinate
                                    // system.
        nv::vec3f m_center;         // Vector indicating the center of a
                                    // bounding box containing the model in
                                    // the application's coordinate system.
        float m_tailStartZ;         // Z position at which the tail starts (for vertex animation)

        nv::matrix4f getCenteringTransform() const
        {
            nv::matrix4f m = m_fixupXfm;
            m.set_translate(-m_center);
            return m;
        }
    };
    static ModelDesc ms_modelInfo[];
    Nv::NvModelExtGL* m_models[MODEL_COUNT];

    // Structure used to define all of the characteristics of a school
    struct SchoolDesc
    {
        uint32_t m_modelId;
        uint32_t m_numFish;
        float    m_scale;
        SchoolFlockingParams m_flocking;
    };
    typedef std::vector<SchoolDesc> SchoolDescSet;

    uint32_t m_maxSchools;
    SchoolDescSet m_schoolDescs;

    // Handles data about schools that persists across frames, such as
    // the last centroid of the school and the last radius, and is thread
    // safe for schools to read other schools' state from and write 
    // their own state to.
    SchoolStateManager m_schoolStateMgr;

    // Static data used to initialize schools and their flocking parameters, etc.
    enum FishTypes
    {
        FISHTYPE_EXTRALARGE = 0,
        FISHTYPE_LARGESLOW,
        FISHTYPE_LARGE,
        FISHTYPE_LARGEFAST,
        FISHTYPE_MEDIUMSLOW,
        FISHTYPE_MEDIUM,
        FISHTYPE_MEDIUMFAST,
        FISHTYPE_MEDIUMSPARSE,
        FISHTYPE_SMALLSLOW,
        FISHTYPE_SMALL,
        FISHTYPE_SMALLFAST,
        FISHTYPE_COUNT
    };
    static SchoolFlockingParams ms_fishTypeDefs[];
    static SchoolDesc ms_schoolInfo[];

    // Allow us to have separate VBO policies for AZDO vs. Non-AZDO modes
    Nv::VBOPolicy m_AZDOVBOPolicy;
    Nv::VBOPolicy m_ESVBOPolicy;

    Nv::VBOPolicy m_currentVBOPolicy;
    // If the current VBO policy is a pooled policy, then the parent 
    // VBO pool is held here.
    Nv::NvSharedVBOGLPool* m_pVBOPool;

    typedef std::vector<School*> SchoolSet;
    SchoolSet m_schools;
    uint32_t m_activeSchools;

    // Scene wide and background shared textures
    GLuint m_skyboxSandTex;
    GLuint m_skyboxGradientTex;

    GLuint m_caustic1Tex;
    GLuint m_caustic2Tex;

    float m_causticTiling;
    float m_causticSpeed;

    // Other state-related member fields
    // (some of them are referenced and controlled by the TweakBar UI)
    // Reset mode is the current setting for the Reset dropdown.
    // See the RESET_* enum for values
    uint32_t m_uiResetMode;

    NvTweakVarBase* m_pFishFireworksVar;
    NvTweakVarBase* m_pFishplosionVar;

    // Flag indicating whether schools should update and animate or remain
    // in their current state
    bool m_animPaused;

    // Flag indicating whether schools should be aware of each other and 
    // attempt to avoid each other
    bool m_avoidance;

    // Current application time in seconds
    float m_currentTime;

    // Main app needs to hold this so that VBOs can be rebuilt if they 
    // no longer reflect the correct number of schools/fish or if the 
    // VBO policy changes
    bool m_bForceSchoolUpdate;  

    // UI trackers
    bool m_bUIDirty;

    enum UIReactionIDs
    {
          UIACTION_SCHOOLCOUNT          = 0x10000001
        , UIACTION_FISHCOUNT         
        , UIACTION_SCHOOLINFOID       
        , UIACTION_SCHOOLMODELINDEX    
        , UIACTION_SCHOOLMAXSPEED      
        , UIACTION_SCHOOLINERTIA       
        , UIACTION_SCHOOLNEIGHBORDIST  
        , UIACTION_SCHOOLGOAL          
        , UIACTION_SCHOOLALIGNMENT      
        , UIACTION_SCHOOLREPULSION    
        , UIACTION_SCHOOLCOHESION    
        , UIACTION_SCHOOLAVOIDANCE      
        , UIACTION_RESET               
        , UIACTION_CAMERAFOLLOWSCHOOL   
        , UIACTION_RESET_FISHPLOSION	
        , UIACTION_RESET_FISHFIREWORKS	
        , UIACTION_ANIMTHREADCOUNT	
        , UIACTION_ANIMPAUSED
        , UIACTION_INSTCOUNT		
        , UIACTION_BATCHSIZE
        , UIACTION_STATSTOGGLE
        , UIACTION_RENDERINGTECHNIQUE
        , UIACTION_TANKSIZE
    };

    uint32_t m_uiSchoolCount;
    uint32_t m_uiFishCount;
    uint32_t m_uiTankSize;
    bool     m_bTankSizeChanged;
    uint32_t m_uiThreadCount;
    uint32_t m_uiInstanceCount;
    uint32_t m_uiBatchSize;
    NvUISlider* m_pBatchSlider;
    NvTweakVar<uint32_t>* m_pBatchVar;
    uint32_t m_uiRenderingTechnique;

    // Details UI
    uint32_t m_uiSchoolInfoId;
    bool m_uiCameraFollow;
    uint32_t m_uiSchoolDisplayModelIndex;
    float m_uiSchoolMaxSpeed;
    float m_uiSchoolInertia;
    float m_uiSchoolNeighborDistance;
    float m_uiSchoolGoalScale;
    float m_uiSchoolAlignmentScale;
    float m_uiSchoolRepulsionScale;
    float m_uiSchoolCohesionScale;
    float m_uiSchoolAvoidanceScale;

    NvUIText* m_simpleTimingStats;
    NvUIContainer* m_simpleStatsBox;

    NvUIText* m_fullTimingStats;
    NvUIContainer* m_fullStatsBox;
    
    // Textures to use when displaying NVIDIA and API logos as well
    // as a flag to indicate whether or not they should be displayed.
    bool m_bDisplayLogos;
    NvUIGraphic* m_logoNVIDIA;
    NvUIGraphic* m_logoGLES;
    NvUIGraphic* m_logoGL;

    // Stats variables
    uint32_t m_drawCallCount;

    enum { STATS_FRAMES = 5 };
    NvCPUTimer m_CPUTimers[CPU_TIMER_COUNT];
    NvGPUTimer m_GPUTimer;
    int32_t m_statsCountdown;

    uint32_t m_statsMode;
    NvTweakVarBase* m_pStatsModeVar;

    // Current Stats
    float m_meanFPS;
    float m_meanCPUMainCmd;
    float m_meanCPUMainWait;
    float m_meanCPUMainCopyVBO;
    float m_meanGPUFrameMS;

    struct ThreadTimings {
        float anim;
        float update;
        float cmd;
        float tot;
    };

    ThreadTimings m_threadTimings[MAX_ANIMATION_THREAD_COUNT];
    volatile uint32_t m_frameID;
};
#endif // ThreadedRenderingGL_H_

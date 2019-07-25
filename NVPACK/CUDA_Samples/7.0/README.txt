CUDA Android Samples installation instructions:

1) In {cuda_android_sample}/cuda/Makefile, change the following paths

    NDK_ROOT  to ANDROID NDK root directory path
    CUDA_TOOLKIT_ROOT to CUDA toolkit root directory path
    
2) In {cuda_android_sample}/jni/Android.mk, change CUDA_ROOT to your CUDA Toolkit root directory path
    
3) For this release contains 4 samples for CUDA on Android projects that includes visualization.

   * bilateralFilter      - This is an edge-preserving non-linear smoothing filter.  
                            Reference: "C. Tomasi, R. Manduchi, Bilateral Filtering for Gray and Color 
                            Images, proceeding of the ICCV, 1998"

   * convolutionSeparable - A 2D convolution separable filter.

   * recursiveGaussian    - A Gaussian blur using Deriche's recursive method.  This algorithm has 
                            the advantage that the execution time is independent of the filter kernel 
                            width.

   * SobelFilter          - An example of a Sobel Edge Detection filter for images.


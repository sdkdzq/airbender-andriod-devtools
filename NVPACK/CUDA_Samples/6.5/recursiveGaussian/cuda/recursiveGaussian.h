/*
 * recursiveGaussian.h
 *
 *  Created on: Oct 17, 2014
 *      Author: ngarg
 */

#ifndef RECURSIVEGAUSSIAN_H_
#define RECURSIVEGAUSSIAN_H_

namespace gpu_recursive_gaussian
{
    class RecursiveGaussian
    {
        public:
            RecursiveGaussian();
            ~RecursiveGaussian();
            // initialize the global memory for image data
            void init(int width, int height,uint *hImage);
            // transpose kernel is launched to transpose the image
            void transpose(uint *d_src, uint *d_dest, uint width, int height);
            // gaussian filter kernel is launched
            void gaussianFilterRGBA(uint *h_dest, int width, int height, float sigma, int order, int nthreads);
        private:
            // original image
            uint *d_img;
            // temp storage for intermediate results
            uint *d_temp;
            // final result of applying a box filter
            uint *d_result;
            // pitch size
            size_t m_pitch;

    };
}//namespace gpu_recursive_gaussian


#endif /* RECURSIVEGAUSSIAN_H_ */

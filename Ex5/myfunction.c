
// metargelim said it is allowed:
#undef _GLIBCXX_DEBUG                // disable run-time bound checking, etc
#pragma GCC optimize("Ofast,inline") // Ofast = O3,fast-math,allow-store-data-races,no-protect-parens
#pragma GCC target("avx,avx2,f16c,fma,sse3,ssse3,sse4.1,sse4.2") // SIMD

#include <stdbool.h> 

typedef struct {
   unsigned char red;
   unsigned char green;
   unsigned char blue;
} pixel;

typedef struct {
    int red;
    int green;
    int blue;
    int num;
} pixel_sum;



#define min(a,b) (((a) < (b)) ? (a) : (b))
#define max(a,b) (((a) > (b)) ? (a) : (b))
#define calcIndex(i,j,n) ((i)*(n)+(j))
#define initialize_pixel_sum(sum)(sum->red = sum->green = sum->blue = 0)

#define size  m*n*sizeof(pixel)



pixel* pixelsImg;
pixel* backupOrg;

static inline  __attribute__((always_inline)) pixel applyKernelBlurFilter7(int dim, int i , int j, pixel *src){
	pixel current_pixel;
	register int min_intensity = 766; // arbitrary value that is higher than maximum possible intensity, which is 255*3=765
	register int max_intensity = -1; // arbitrary value that is lower than minimum possible intensity, which is 0
	register int min_row, min_col, max_row, max_col;
	register int g,b,r;
	pixel loop_pixel;
	
	register pixel *kernalArr = src + calcIndex(i-1, j-1, dim);

	r =  kernalArr->red  + 	(kernalArr+1)->red + (kernalArr+2)->red;
	g =  kernalArr->green  + (kernalArr+1)->green  + (kernalArr+2)->green;
	b =  kernalArr->blue + 	(kernalArr+1)->blue  + (kernalArr+2)->blue;

	kernalArr += dim;

	r +=  kernalArr->red  + (kernalArr+1)->red + (kernalArr+2)->red;
	g +=  kernalArr->green + (kernalArr+1)->green  + (kernalArr+2)->green;
	b +=  kernalArr->blue + (kernalArr+1)->blue + (kernalArr+2)->blue;


	kernalArr += dim;

	r +=  kernalArr->red  + (kernalArr+1)->red + (kernalArr+2)->red;
	g +=  kernalArr->green + (kernalArr+1)->green  + (kernalArr+2)->green ;
	b +=  kernalArr->blue + (kernalArr+1)->blue + (kernalArr+2)->blue;


// asdasdasd
	int index = calcIndex(i-1, j-1, dim);
	loop_pixel = *(src + index);
	int intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));
	min_intensity = intensity;
	min_row = i-1;
	min_col = j-1;
	max_intensity = intensity;
	max_row = i-1;
	max_col = j-1;
	

	loop_pixel = *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));
	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i-1;
		min_col = j;
	}
	if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i-1;
		max_col = j;
	}

	loop_pixel = *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));
	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i-1;
		min_col = j+1;
	}
	if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i-1;
		max_col = j+1;
	}

	index +=  (dim-2);
	loop_pixel = *(src + index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));
	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i;
		min_col = j-1;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i;
		max_col = j-1;
	}

	loop_pixel = *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));

	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i;
		min_col = j;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i;
		max_col = j;
	}

	loop_pixel = *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));

	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i;
		min_col = j+1;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i;
		max_col = j+1;
	}
	
	index += (dim-2);
	loop_pixel = *(src + index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));

	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i+1;
		min_col = j-1;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i+1;
		max_col = j-1;
	}

	loop_pixel =  *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));

	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i+1;
		min_col = j;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i+1;
		max_col = j;
	}

	loop_pixel =  *(src + ++index);
	intensity = (((int) loop_pixel.red) + ((int) loop_pixel.green) + ((int) loop_pixel.blue));
	if (intensity <= min_intensity) {
		min_intensity = intensity;
		min_row = i+1;
		min_col = j+1;
	}else if (intensity > max_intensity) {
		max_intensity = intensity;
		max_row = i+1;
		max_col = j+1;
	}
		

	// filter out min and max
	pixel p =  *(src + calcIndex(min_row, min_col, dim));
	pixel p2 =  *(src + calcIndex(max_row, max_col, dim));
	r -= (p.red + p2.red);
	g -= (p.green + p2.green);
	b -= (p.blue+ p2.blue);
	
	r /= 7;
	g /= 7;
	b /= 7;

	// truncate each pixel's color values to match the range [0,255]
	current_pixel.red = (unsigned char) (min(max(r, 0), 255));
	current_pixel.green = (unsigned char) (min(max(g, 0), 255));
	current_pixel.blue = (unsigned char) (min(max(b, 0), 255));

	return current_pixel;
}


static inline  __attribute__((always_inline)) pixel applyKernelSharpNoFilter(int dim, int i, int j, pixel *src) {

	pixel current_pixel;
	register pixel * kernalArr = src + calcIndex(i-1, j-1, dim);
	register int r,g,b;
	r =  kernalArr->red * -1 + 	(kernalArr+1)->red * -1 + (kernalArr+2)->red * -1;
	g =  kernalArr->green * -1 + 	(kernalArr+1)->green * -1 + (kernalArr+2)->green * -1;
	b =  kernalArr->blue * -1 + 	(kernalArr+1)->blue * -1 + (kernalArr+2)->blue * -1;

	kernalArr += dim;

	r +=  kernalArr->red * -1 + 	(kernalArr+1)->red * 9 + (kernalArr+2)->red * -1;
	g +=  kernalArr->green * -1 + 	(kernalArr+1)->green * 9 + (kernalArr+2)->green * -1;
	b +=  kernalArr->blue * -1 + 	(kernalArr+1)->blue * 9 + (kernalArr+2)->blue * -1;


	kernalArr += dim;

	r +=  kernalArr->red * -1 + 	(kernalArr+1)->red * -1 + (kernalArr+2)->red * -1;
	g +=  kernalArr->green * -1 + 	(kernalArr+1)->green * -1 + (kernalArr+2)->green * -1;
	b +=  kernalArr->blue * -1 + 	(kernalArr+1)->blue * -1 + (kernalArr+2)->blue * -1;

	// truncate each pixel's color values to match the range [0,255]
	current_pixel.red = (unsigned char) (min(max(r, 0), 255));
	current_pixel.green = (unsigned char) (min(max(g, 0), 255));
	current_pixel.blue = (unsigned char) (min(max(b, 0), 255));
	return current_pixel;
}



static inline  __attribute__((always_inline)) pixel applyKernelBlurNoFilter9(int dim, int i, int j, pixel *src) {
	register int r,g,b;
	pixel current_pixel;
	register pixel * kernalArr = src + calcIndex(i-1, j-1, dim);
	
	r =  kernalArr->red  + 	(kernalArr+1)->red + (kernalArr+2)->red;
	g =  kernalArr->green  + (kernalArr+1)->green  + (kernalArr+2)->green;
	b =  kernalArr->blue + 	(kernalArr+1)->blue  + (kernalArr+2)->blue;

	kernalArr += dim;

	r +=  kernalArr->red  + (kernalArr+1)->red + (kernalArr+2)->red;
	g +=  kernalArr->green + (kernalArr+1)->green  + (kernalArr+2)->green ;
	b +=  kernalArr->blue + (kernalArr+1)->blue + (kernalArr+2)->blue;


	kernalArr += dim;

	r  +=  kernalArr->red  + (kernalArr+1)->red + (kernalArr+2)->red;
	g +=  kernalArr->green + (kernalArr+1)->green  + (kernalArr+2)->green ;
	b  +=  kernalArr->blue + (kernalArr+1)->blue + (kernalArr+2)->blue;


	// assign kernel's result to pixel at [i,j]
	r /=9;
	g /=9;
	b /=9;

	// truncate each pixel's color values to match the range [0,255]
	current_pixel.red = (unsigned char) (min(max(r, 0), 255));
	current_pixel.green = (unsigned char) (min(max(g, 0), 255));
	current_pixel.blue = (unsigned char) (min(max(b, 0), 255));
	return current_pixel;
}



inline  __attribute__((always_inline)) void smoothSharpNoFilter(int dim, pixel *src, pixel *dst) {
	register int i, j;
	for (i = 1 ; i < dim -1; i++) {
		for (j =  1 ; j < dim - 1 ; j++) {
			dst[calcIndex(i, j, dim)] = applyKernelSharpNoFilter(dim, i, j, src);
		}
	}
}

inline  __attribute__((always_inline)) void smoothBlurNoFilter9(int dim, pixel *src, pixel *dst) {
	int i, j;
	for (i = 1 ; i < dim -1; ++i) {
		for (j =  1 ; j < dim - 1 ; ++j) {
			dst[calcIndex(i, j, dim)] = applyKernelBlurNoFilter9(dim, i, j, src);
		}
	}
}


void smoothBlurFilter7(int dim, pixel *src, pixel *dst) {
	int i, j;
	for (i = 1 ; i < dim -1; i++) {
		for (j =  1 ; j < dim - 1 ; j++) {
			dst[calcIndex(i, j, dim)] = applyKernelBlurFilter7(dim, i, j, src);
		}
	}
}

void charsToPixels(Image *charsImg, pixel* pixels) {
	memcpy(pixels, charsImg->data ,size);
}

void pixelsToChars(pixel* pixels, Image *charsImg) {
	memcpy(charsImg->data,pixels ,size);
}

void copyPixels(pixel* src, pixel* dst) {
	memcpy(dst,src ,size);
}

void doConvolutionSharpNoFilter(Image *image) {

	charsToPixels(image, pixelsImg);
	copyPixels(pixelsImg, backupOrg);

	smoothSharpNoFilter(m, backupOrg, pixelsImg);

	pixelsToChars(pixelsImg, image);


    free(pixelsImg);
    free(backupOrg);
}


void doConvolutionBlurNoFilter9(Image *image) {

	pixelsImg = malloc(size);
	backupOrg = malloc(size);

	charsToPixels(image, pixelsImg);
	copyPixels(pixelsImg, backupOrg);

	smoothBlurNoFilter9(m, backupOrg, pixelsImg);

	pixelsToChars(pixelsImg, image);

}



void doConvolutionBlurFilter7(Image *image) {

	pixelsImg = malloc(size);
	backupOrg = malloc(size);

	charsToPixels(image, pixelsImg);
	copyPixels(pixelsImg, backupOrg);

	smoothBlurFilter7(m, backupOrg, pixelsImg);

	pixelsToChars(pixelsImg, image);
}

void myfunction(Image *image, char* srcImgpName, char* blurRsltImgName, char* sharpRsltImgName, char* filteredBlurRsltImgName, char* filteredSharpRsltImgName, char flag) {

	if (flag == '1') {	

		// blur image
		doConvolutionBlurNoFilter9(image);

		// write result image to file
		writeBMP(image, srcImgpName, blurRsltImgName);	

		// sharpen the resulting image
		doConvolutionSharpNoFilter(image);
		
		// write result image to file
		writeBMP(image, srcImgpName, sharpRsltImgName);	
	} else {
		// apply extermum filtered kernel to blur image
		doConvolutionBlurFilter7(image);

		// write result image to file
		writeBMP(image, srcImgpName, filteredBlurRsltImgName);

		// sharpen the resulting image
		doConvolutionSharpNoFilter(image);

		// write result image to file
		writeBMP(image, srcImgpName, filteredSharpRsltImgName);	
	}
}

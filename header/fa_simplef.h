// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// fa_simple.h contains C function signatures for all "basic" or
// "building-block" functions, mostly optimized arithmetic functions,
// including a lot of vector floating point (32-bit) operations.

#ifndef FASTARM_SIMPLE_FP32
#define FASTARM_SIMPLE_FP32

/**
	Compute and return the average of the data stored in the array |data|.
	Average = Sum(data) / len
*/
float fa_avgf(float* data, unsigned len);

/**
	Compute the sum of all numbers stored in the array |data|.
*/
float fa_sumf(float* data, unsigned len);

/**
	Compute the product of all the numbers stored in the array |data|.
*/
float fa_productf(float* data, unsigned len);

/**
	Find and return the highest number stored in the array |data|.
*/
float fa_maximumf(float* data, unsigned len);

/**
	Find and return the lowest (-1 < 0 < 1) number stored in the array |data|.
*/
float fa_minimumf(float* data, unsigned len);

/**
	Fast-compute the integer square root of the supplied number.
*/
unsigned fa_sqrt32(unsigned number);

/**
	Compute and return the inverse square root of number.
	Is slower than fa_isqrtf_fast, but is much more accurate (several orders of magnitude).
*/
float fa_isqrtf(float number);

/**
	Compute and return the inverse square root of number.
	Is considerably faster than fa_isqrtf, but has a much larger error margin.
*/
float fa_isqrtf_fast(float number);


/**
destination = |a_i * b_i| for i from 0 to length
*/
void fa_vecmultiplyf(float* a, float* b, float* destination, unsigned length);

/// a = |a_i + (b_i * c_i)| for i from 0 to length
float* fa_vecfmaf(float* a, float* b, float* c, unsigned length);

/// a = |a_i - (b_i * c_i)| for i from 0 to length
float* fa_vecfmsf(float* a, float* b, float* c, unsigned length);


#endif

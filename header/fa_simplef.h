#ifndef FASTARM_SIMPLE_FP32
#define FASTARM_SIMPLE_Fp32

float fa_avgf(float* data, unsigned len);
float fa_sumf(float* data, unsigned len);
float fa_productf(float* data, unsigned len);
float fa_maximumf(float* data, unsigned len);
float fa_minimumf(float* data, unsigned len);

unsigned fa_sqrt32(unsigned number);
float fa_isqrtf(float number);
float fa_isqrtf_fast(float number);


/// destination = |a_i * b_i| for i from 0 to length
void fa_vecmultiplyf(float* a, float* b, float* destination, unsigned length);

/// a = |a_i + (b_i * c_i)| for i from 0 to length
float* fa_vecfmaf(float* a, float* b, float* c, unsigned length);

/// a = |a_i - (b_i * c_i)| for i from 0 to length
float* fa_vecfmsf(float* a, float* b, float* c, unsigned length);


#endif

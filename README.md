# fastarm
FastARM: Optimized libraries for the mobile world

## What's FastARM?
FastARM is a collection of optimized functions written directly in 32-bit ARM assembly, assembling both "basic" functions such as vector math operations, and more practical applications, including cryptography.

## Compatibility
FastARM is currently targeted at:
 - ARMv6 (including the **Raspberry Pi**)
 - ARMv7A/M/R, including most Android phones; Raspberry Pi 2; iPhone 4 to 5
 - ARMv8 AArch32, including the iPhone 5S, 6, 6 Plus
 - 

## Caveats
The instruction set used is specific to 32-bit ARM architectures, and will not be useable when compiling for the AArch64 aspect of the ARMv8 instruction set architecture.

## Example functions
  - Float vector summing, product
  - Fast integer square root
  - *FAST* RC4 implementation, yielding more than 40MB/s on a stock Raspberry Pi B.

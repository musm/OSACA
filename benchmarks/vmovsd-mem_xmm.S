#define INSTR vmovsd
#define NINST 64
#define N edi
#define i r8d


.intel_syntax noprefix
.globl ninst
.data
ninst:
.long NINST
.align 32
PI:
.long  0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9, 0xf01b866e, 0x400921f9
.text
.globl latency
.type latency, @function
.align 32
latency:
		push      rbp
		mov       rbp, rsp
		xor       i, i
		test      N, N
		jle       done
		# create DP 1.0
		vpcmpeqw xmm0, xmm0, xmm0		# all ones
		vpsllq xmm0, xmm0, 54			# logical left shift: 11111110..0 (54=64-(10-1))
		vpsrlq xmm0, xmm0, 2			# logical right shift: 1 bit for sign; leading      mantissa bit is zero
		# copy DP 1.0
		vmovaps xmm0, xmm0
		vmovaps xmm1, xmm0
		# Create DP 2.0
		vaddpd xmm1, xmm1, xmm1
		# Create DP 0.5
		vdivpd xmm2, xmm0, xmm1
loop:
		inc      i
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		INSTR    [rip+PI], xmm0
		cmp      i, N
		jl       loop
done:
		mov	rsp, rbp
		pop	rbp
		ret
.size latency, .-latency
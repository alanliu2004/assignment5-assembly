	.file	"assgn5.c"			# file name
	.text						# switches to code section
	.section	.rodata			# switches to read-only data section
.LC0:							# named location
	.string	"%d "				# stores "%d "
	.text						# switches back to code section
	.globl	main				# makes main visible
	.type	main, @function		# declares main as a function
main:							# label for main
.LFB0:							# position label
	.cfi_startproc				# marks the start of the function for the debugger
	endbr64						# intel cpu security intructions
	pushq	%rbp				# saves the base pointer onto the stack
	.cfi_def_cfa_offset 16		# debugger metadata
	.cfi_offset 6, -16			# debugger metadata
	movq	%rsp, %rbp			# sets %rbp to the current stack pointer
	.cfi_def_cfa_register 6		# debugger metadata
	subq	$48, %rsp			# subtracts 48 bytes from the stack pointer
	movq	%fs:40, %rax		# loads stack canary into %rax
	movq	%rax, -8(%rbp)		# stores the stack canary on the stack
	xorl	%eax, %eax			# clears %eax
	movl	$1, -32(%rbp)		# stores array[0] = 1 at -32(%rbp)
	movl	$2, -28(%rbp)		# stores array[1] = 2 at -28(%rbp)
	movl	$3, -24(%rbp)		# stores array[2] = 3 at -24(%rbp)
	movl	$4, -20(%rbp)		# stores array[3] = 4 at -20(%rbp)
	movl	$5, -16(%rbp)		# stores array[4] = 5 at -16(%rbp)
	movl	$5, -36(%rbp)		# stores size = 5 at -36(%rbp)
	movl	$0, -44(%rbp)		# stores i = 0 at -44(%rbp)
	jmp	.L2						# jump to .L2
.L3:							# position label
	movl	-44(%rbp), %eax		# loads i in %eax registry
	cltq						# expands i to 64-bits in %rax
	leaq	0(,%rax,4), %rdx	# calculates i * 4 and stores it in %rdx
	leaq	-32(%rbp), %rax		# stores the address of array[0] in %rax
	addq	%rdx, %rax			# adds i * 4 to the address of array[0] and stores it in %rax
	movl	(%rax), %edx		# loads the value of array[i] in %edx
	movl	-44(%rbp), %eax		# loads value of i in %eax
	cltq						# expands i to 64-bits in %rax
	leaq	0(,%rax,4), %rcx	# calculates i * 4 and stores it in %rcx
	leaq	-32(%rbp), %rax		# stores the address of array[0] in %rax
	addq	%rcx, %rax			# adds i * 4 to array[0] and stores it in %rax
	movl	(%rax), %eax		# loads the value of array[0] in %eax
	movl	-44(%rbp), %ecx		# loads the value of i in %ecx
	movslq	%ecx, %rcx			# expands %ecx to 64 bits and stores it in %rcx
	leaq	0(,%rcx,4), %rsi	# calculates i * 4 and stores it in %rsi
	leaq	-32(%rbp), %rcx		# stores the address of array[0] in %rcx
	addq	%rsi, %rcx			# adds i * 4 to the address of array[0] and stores it in %rcx
	imull	%edx, %eax			# multiplies %edx and %eax and stores it in %eax
	movl	%eax, (%rcx)		# stores squared result back into the array[i]
	addl	$1, -44(%rbp)		# adds 1 to the value stored at -44(%rbp) and store it back there; i++
.L2:							# position label
	movl	-44(%rbp), %eax		# loads the value at -44(%rbp) in %eax
	cmpl	-36(%rbp), %eax		# calculates %eax - -36(%rbp)
	jl	.L3						# checks if the cmpl value is negative, if so, jump to .L3
	movl	$0, -40(%rbp)		# stores 0 at -40(%rbp); initializes print loop at i = 0
	jmp	.L4						# jump to .L4
.L5:							# position label
	movl	-40(%rbp), %eax		# loads the value of -40(%rbp) (i = 0) in %eax
	cltq						# expands i to 64-bits and stores it in %rax
	leaq	0(,%rax,4), %rdx	# calculates i * 4 and stores it in %rdx
	leaq	-32(%rbp), %rax		# stores the address of -32(%rbp) in %rax
	addq	%rdx, %rax			# adds the value of %rax and %rdx and stores it back in %rax
	movl	(%rax), %eax		# loads the value of %rax in %eax
	movl	%eax, %esi			# moves %eax in %esi
	leaq	.LC0(%rip), %rax	# loads the address of "%d " into %rax
	movq	%rax, %rdi			# moves %rax in %rdi
	movl	$0, %eax			# stores 0 at %eax (return 0)
	call	printf@PLT			# calls printf to print array[i]
	addl	$1, -40(%rbp)		# add 1 to -40(%rbp); i++
.L4:							# position label
	movl	-40(%rbp), %eax		# loads of value of -40(%rbp) in $eax
	cmpl	-36(%rbp), %eax		# calculates %eax - -36(%rbp)
	jl	.L5						# checks if the cmpl value is negative, if so, jump to .L5
	movl	$0, %eax			# clears %eax before calling printf
	movq	-8(%rbp), %rdx		# loads of value of -8(%rbp) in $rdx
	subq	%fs:40, %rdx		# subtracts the stack canary to check if it was modified
	je	.L7						# if it not is modified, jump to .L7
	call	__stack_chk_fail@PLT	# if canary was modified, called stack overflow error
.L7:							# position label
	leave						# restores stack frame
	.cfi_def_cfa 7, 8			# debugger metadata
	ret							# return to caller, ending the program
	.cfi_endproc				# end of debugger
.LFE0:							# position label
	.size	main, .-main		# records the size of main for the linker
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"	# compiler version
	.section	.note.GNU-stack,"",@progbits	# marks the stack as non-executable
	.section	.note.gnu.property,"a"			# GNU property section
	.align 8									# aligns to 8 bytes
	.long	1f - 0f								# size of vender name
	.long	4f - 1f								# size of proprety data
	.long	5									# property type
0:								# position label
	.string	"GNU"				# vender name
1:								# position label
	.align 8					# aligns to 8 bytes
	.long	0xc0000002			# property type: ISA features
	.long	3f - 2f				# size of proprety data
2:								# position label
	.long	0x3					# ISA level value
3:								# position label
	.align 8					# aligns to 8 bytes
4:								# end position label

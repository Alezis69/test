# C code for loop below
# int A[] = {1, 2, 0};
# for (int i = 0; i < 3; i++) {
#     result += A[A[i]];
# }

.data
# Define the array A
A: .word 4, 2, 0        # Array A
len: .word 3            # Length of the array
result: .word 0         # Placeholder for the result of A[A[I]]

.text
.globl _start

# For pipeline simulation assume these lines have already run and
# the values are in the registers
# s0 = &A, s1 = len
# s2 = 0 (index i), # s3 = 0
# s4 = &result

# Uncomment the following lines to run on venus
# _start:
#     la s0, A            # Load the base address of array A into s0
#     lw s1, len          # Load the length of the array into s1
#     li s2, 0            # Initialize index (i) to 0
#     li s3, 0            # Initialize result to 0
#     la s4, result
loop:
    bge s2, s1, end     # If index (i) >= length, exit loop
    slli s4, s2, 2      # i * 4 (calculate offset for A[i])
    add s5, s0, t4      # s5 = address of A[i]
    lw s6, 0(t5)        # Load A[i] into s6
    slli s7, s6, 2      # s7 = A[i] * 4 (calculate offset for A[A[i]])
    add t6, s0, s7      # t1 = address of A[A[i]]
    lw t1, 0(t6)        # Load A[A[i]] into t1
    add t3, t3, t1      # Accumulate result = result + A[A[i]]
    addi s2, s2, 1      # Increment index (i)
    j loop              # Jump back to the loop

end:
    sw t3, 0(t4)       # Store the final result in memory
    addi a7,zero,10
    ecall               # End program

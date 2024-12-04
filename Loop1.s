# int array[] = {0, 0, 1};
# count = 0
# for (int i = 0; i < 3; i++) {
# if (array[i] != 0) {
# count += 1;
# }

.data
array: .word 0,0,1  # Define an array
len:   .word 3              # Length of the array
result: .word 0             # Memory location to store the result

.text
.globl _start


# For pipeline simulation assume these lines have already run and
# the values are in the registers
# t0 = &array, t1 = len, t4 = 0, t3 = 0

# If you want to run on venus. Uncomment
# _start:
#     la t0, array       # Load the base address of the array
#     lw t1, len         # Load the length of the array into t1
#     li t4, 0           # Initialize the count in t4
#     la t3, result      #
loop:
    beqz t1, end      # If length is zero, exit loop
    lw t2,0(t0)       # Load the current array element
    beq t2,zero,back # If the element is zero, jump to back
    addi t4,t4,1      # Increment the count
back:
    addi t0,t0,4
    addi t1, t1, -1    # Decrement the counter
    j loop             # Jump back to the beginning of the loop

end:
    sw t4, 0(t3)      # Store the count in memory
    addi a0, zero,10
    ecall              # End of program
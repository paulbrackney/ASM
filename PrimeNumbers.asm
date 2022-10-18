# Paul Brackney
# paul.brackney@okstate.edu
# 10-17-2022
# program to print all prime numbers between  2 user-entered integers

.text

.globl main

    main: 

        # prompt user to enter first integer
        li $v0, 4
        la $a0, msg1
        syscall

        # accept integer input and store in $a1
        li $v0, 5
        syscall
        addi $a1, $v0, 0

        # prompt user to enter second integer
        li $v0, 4
        la $a0, msg2
        syscall

        # accept integer input and store in $a2
        li $v0, 5
        syscall
        addi $a2, $v0, 0

        # if n2 >= n1 then don't adjust values
        bge $a2, $a1, continue

        # otherwise, adjust values
        add $a1, $a1, $a2
        sub $a2, $a1, $a2
        sub $a1, $a1, $a2

        j continue

        continue: 

            # print result message
            li $v0, 4
            la $a0, resultMsg
            syscall

            # print new newLine
            li $v0, 4
            la $a0, newLine
            syscall

            # i = n1 + 1
            addi $a3, $a1, 1

            loop: 

                # if (i >= n2) then exit the loop
                bge $a3, $a2, end

                # store i in $a0 and then call function on i 
                addi $a0, $a3, 0
                jal checkPrimeNumber

                # if checkPrimeNumber(i) != 0 then increment i and repeat loop
                bne $v1, $0, increment

                # otherwise, checkPrimeNumber(i) == 0 so print value of i and a new line
                li $v0, 1
                addi $a0, $a3, 0
                syscall

                li $v0, 4
                la $a0, newLine
                syscall

                j increment

                increment: 

                    addi $a3, $a3, 1

                    j loop

            end: 

                # end program
                li $v0, 10
                syscall




    checkPrimeNumber: 

        # flag = 0
        addi $v1, $0, 0

        # $v0 = n/2
        addi $t1, $0, 2 # $t1 = 2
        div $a3, $t1
        mflo $v0

        # j = 2
        addi $a0,$0,2

        while: 

            # if j > n/2 then exit loop
            bgt $a0, $v0, exit

            # store remainder of n/j in $t2
            div $a3, $a0
            mfhi $t2

            # if remainder == 0 then set flag to 1 and exit function
            beq $t2, $0, exit2

            # if remainder != 0 then increment j and repeat the loop
            addi $a0, $a0, 1
            j while

        exit: 

        jr $ra

        exit2: 

        # flag = 1
        addi $v1, $0, 1
        jr $ra



.data

    msg1: .asciiz "Please enter the first integer: "
    msg2: .asciiz "Please enter the second integer: "
    resultMsg: .asciiz "Prime numbers between your two integers are: "
    newLine: .asciiz "\n"


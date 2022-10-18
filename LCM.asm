# Paul Brackney
# paul.brackney@okstate.edu
# 10-17-2022
# program to print LCM of 2 user-entered integers
.text

.globl main

    main: 

        #prompt user to enter first integer
        li $v0, 4
        la $a0, msg1
        syscall

        #accept first integer input and store in $a1
        li $v0, 5
        syscall
        addi $a1, $v0, 0

        #prompt user to enter second integer
        li $v0, 4
        la $a0, msg2
        syscall

        #accept another integer input and store in $a2
        li $v0, 5
        syscall
        addi $a2, $v0, 0

        # gcd = n1 where gcd = $a3 and n1 = $a1
        addi $a3, $a1, 0

        # n2Modified = n2 where n2Modified = $a0 and n2 = $a2
        addi $a0, $a2, 0

        # create while loop 
        while: 

            # if (gcd == n2Modified) then exit loop
            beq $a3, $a0, exit
            # if gcd > n2Modified then jump to if branch
            bgt $a3, $a0, if
            
            # else branch
            sub $a0, $a0, $a3
            j while

        if: 

            sub $a3, $a3, $a0
            j while

        # after loop exits, code continues here
        exit: 

            # call function
            jal LCM 

            # print result message
            li $v0, 4
            la $a0, resultMsg
            syscall

            # print result of LCM calculation
            li $v0, 1
            addi $a0, $v1, 0
            syscall

            #exit the program
            li $v0, 10
            syscall

    LCM: #calculate LCM of $a1 and $a2 with gcd of $a3

        # lcm = (n1 * n2) / gcd

        # store n1 * n2 in $t1
        mult $a1, $a2
        mflo $t1

        # divide $t1 by gcd and store in $v1 (return value)
        div $t1, $a3
        mflo $v1

        jr $ra #return to main



.data

    msg1: .asciiz "Enter the first positive integer: "
    msg2: .asciiz "Enter the second positive integer: "
    resultMsg: .asciiz "The LCM of two numbers is "
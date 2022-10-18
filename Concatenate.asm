# Paul Brackney
# paul.brackney@okstate.edu
# 10-17-2022
# program to concatenate 2 strings


.text

.globl main

    main: 

        # prompt user to enter first string
        li $v0, 4
        la $a0, msg1
        syscall

        #set $a2 to 0 (index of character array)
        addi $a2, $0, 0

        # set t1 equal to ascii code for new  line
        li $t1, 10

        # read first character and store in char array
        li $v0, 12
        syscall

        sb $v0, str1($a2)

        # if character is not new line, fgets() to fill char array
        # if character is new line, return to new main function
        bne $v0, $t1, fgets1
        beq $v0, $t1, returnMain

    fgets1: 
        # set $t1 to new line
        li $t1, 10

        # set  $t2 to 49
        li $t2, 49

        # if index is 49, char array is full so end loop
        beq $a2, $t2, returnMain

        #read a character
        li $v0, 12
        syscall

        # increase index by 1
        addi $a2, $a2, 1

        #  add character to string 
        sb $v0, str1($a2)

        # if entered character is not a new line, repeat function
        bne $t1, $v0, fgets1
        beq $t1, $v0, returnMain

    returnMain: 

        # print new  line
        li  $v0, 4
        la $a0, newLine
        syscall

        # prompt user to enter second  string
        li $v0, 4
        la $a0, msg2
        syscall

        #set $a2 to 0 (index of character array)
        addi $a2, $0, 0

        # set t1 equal to ascii code for new  line
        li $t1, 10

        # read first character and store in char array
        li $v0, 12
        syscall

        sb $v0, str2($a2)

        # if character is not new line, fgets() to fill char array
        # if character is new line, return to new main function
        bne $v0, $t1, fgets2
        beq $v0, $t1, concatenate

    fgets2: 

        # set $t1 to new line
        li $t1, 10

        # set  $t2 to 49
        li $t2, 49

        # if index is 49, char array is full so end loop
        beq $a2, $t2, concatenate

        #read a character
        li $v0, 12
        syscall

        # increase index by 1
        addi $a2, $a2, 1

        #  add character to string 
        sb $v0, str2($a2)

        # if entered character is not a new line, repeat function
        bne $t1, $v0, fgets2
        beq $t1, $v0, concatenate

    concatenate: 

        li $v0, 4
        la $a0, newLine
        syscall

        addi $a0, $0, 0
        li $a1, 10
        li $a2, 50
        addi $a3, $0, 0

        print1: 

            beq $a0, $a2, print2

            lb $v1, str1($a0)

            beq $a1, $v1, print2

            sb $v1, str3($a0)

            addi $a0, 1

            bne $a1, $v1, print1

        print2: 

            beq $a3, $a2, exit

            lb $v1, str2($a3)

            sb $v1, str3($a0)

            addi $a0, 1
            addi $a3, 1

            beq $a1, $v1, exit
            bne $a1, $v1, print2

        exit: 

            li $v0, 4
            la $a0, msg3
            syscall

            li $v0, 4
            la $a0, str3
            syscall

            li $v0, 10
            syscall



.data

    msg1: .asciiz "Enter the first string: "
    msg2: .asciiz "Enter the second string: " 
    newLine: .asciiz "\n"
    msg3: .asciiz "Combined String: "
    

    # create arrays large enough for 50 or 100 characters
    str1: .space 50
    str2: .space 50
    str3: .space 100

# Assembly Breakout Clone Game! 
# by mayumon (Malu B.)

############################ Bitmap Display Setup ############################

# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)

##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################

# The address of the bitmap display. Ensure connection.
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Ensure connection.
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

red:	.word 0xFF8DA2
yellow: .word 0xFFE769
green:	.word 0x8DF1A9
blue:	.word 0x84D7FF
purple:	.word 0xB6B2FF
white:	.word 0xFFFFFF
grey:	.word 0x4F4F4F
black:	.word 0x000000

ball: .word 0x0

ball_vx: .word 1 # Initialize ball_vx to 1
ball_vy: .word 1

paddle_l: .word 0x0
paddle_r: .word 0x0

paddle_l2: .word 0x0
paddle_r2: .word 0x0

addr_lower_bound: .word 0x0
hearts: .word 3

##############################################################################
# Code
##############################################################################
	.text
	.globl main

######### Run the Brick Breaker game #########

main:

######### Initialize the game #########

	lw $t0, ADDR_DSPL	# load the base address for display to $t0
	lw $s0, black		# $s0 = black
	li $t3, 0		# $t3 = 0

# Remove any remaining pixels on the display
erase_screen:
	sw $s0, 0($t0)			# make current pixel at $t0 black
	add $t0, $t0, 4			# $t0 += 4
	add $t3, $t3, 1			# $t3++
	bne $t3, 1048, erase_screen	# branch if ($t3 != 1048)
	
	
	lw $t0, ADDR_DSPL       	# load the base address for display to $t0
    	add $t3, $t0, 4088		# $t3 = $t0 + 4088
    	sw $t3, addr_lower_bound	# addr_lower_bound = $t3

	li $t3, 0	# $t3 = 0
	lw $t4, white	# $t4 = white
	
# Draw the top border on the display
draw_top_border:
	sw $t4, 0($t0)			# make current pixel at $t0 white
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 224, draw_top_border	# branch if ($t3 != 224)
	
	li $t3, 0	# $t3 = 0
	
# Draw the left and right borders on the display
draw_left_right_border:
	sw $t4, 0($t0)				# make current pixel at $t0 white
	addi $t0, $t0, 4			# $t0 += 4
	sw $t4, 0($t0)				# make current pixel at $t0 white
	addi $t0, $t0, 116			# $t0 += 116
	sw $t4, 0($t0)				# make current pixel at $t0 white
	addi $t0, $t0, 4			# $t0 += 4
	sw $t4, 0($t0)				# make current pixel at $t0 white
	addi $t0, $t0, 4			# $t0 += 4
	addi $t3, $t3, 1			# $t3++
	bne $t3, 25, draw_left_right_border	# branch if ($t3 != 25)
	
	li $t3, 0		# $t3 = 0
	lw $t0, ADDR_DSPL	# load the base address for display to $t0
	addi $t0, $t0, 904	# $t0 += 904
	lw $t4, red		# $t4 = red

# Draw the 1st row of bricks on the display
draw_bricks_row1:
	sw $t4, 0($t0)			# make current pixel at $t0 red
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 28, draw_bricks_row1	# branch if ($t3 != 28)
	
	# Set register values for drawing next brick row
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, 16	# $t0 += 16
	
	lw $t4, yellow	#t4 = yellow

# Draw the 2nd row of bricks on the display
draw_bricks_row2:
	sw $t4, 0($t0)			# make current pixel at $t0 yellow
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 28, draw_bricks_row2	# branch if ($t3 != 28)
	
	# Set register values for drawing next brick row
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, 16	# $t0 += 16
	
	lw $t4, green	#t4 = green
	
# Draw the 3rd row of bricks on the display
draw_bricks_row3:
	sw $t4, 0($t0)			# make current pixel at $t0 green
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 28, draw_bricks_row3	# branch if ($t3 != 28)
	
	# Set register values for drawing next brick row
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, 16	# $t0 += 16
	
	lw $t4, blue #t4 = blue
	
# Draw the 4th row of bricks on the display
draw_bricks_row4:
	sw $t4, 0($t0)			# make current pixel at $t0 blue
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 28, draw_bricks_row4	# branch if ($t3 != 28)
	
	# Set register values for drawing next brick row
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, 16	# $t0 += 16
	
	lw $t4, purple #t4 = purple
	
# Draw the 5th row of bricks on the display
draw_bricks_row5:
	sw $t4, 0($t0)			# make current pixel at $t0 purple
	addi $t0, $t0, 4		# $t0 += 4
	addi $t3, $t3, 1		# $t3++
	bne $t3, 28, draw_bricks_row5	# branch if ($t3 != 28)

	
# Draw the ball's starting position
	addi $t0, $t0, 148	# $t0 += 148
	sw $t0, ball      	# store the address of the ball to memory
	
	lw $t4, white		# $t4 = white
	sw $t4, 0($t0)		# make current pixel at $t0 white
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, 2216	# $t0 += 2216
	
	sw $t0, paddle_l     # store the address of the left end of upper paddle to memory
	
# Draw the lower paddle's starting position
draw_lower_paddle:
	sw $t4, 0($t0)			# make current pixel at $t0 white
	addi $t3, $t3, 1		# $t3++
	addi $t0, $t0, 4		# # $t0 += 4
	bne $t3, 6, draw_lower_paddle	# branch if ($t3 != 6)

	addi $t0, $t0, -4		# $t0 -= -4	
	sw $t0, paddle_r		# store the address of the right end of upper paddle to memory
	
	# Set register values for drawing lower paddle
	li $t3, 0		# $t3 = 0
	addi $t0, $t0, -276	# $t0 -= 276
	sw $t0, paddle_l2	# store the left end of lower paddle to memory
	
# Draw the lower paddle's starting position
draw_upper_paddle2:
	sw $t4, 0($t0)			# make current pixel at $t0 white
	addi $t3, $t3, 1		# $t3++
	addi $t0, $t0, 4		# $t0 += 4
	bne $t3, 6, draw_upper_paddle2	# branch if ($t3 != 6)
	
	
	addi $t0, $t0, -4	# $t0 -= 4
	sw $t0, paddle_r2	# store the right end of lower paddle to memory
	
	# Set register values for drawing hearts
	lw $t0, ADDR_DSPL	# load the base address for display to $t0
	add $t0, $t0, 140	# $t0 += 140
	lw $t4, black		# $t4 = black
	li $t3, 0		# $t3 = 0

# Draw hearts on top border
heart:
	sw $t4,  0($t0)
	add $t0, $t0, 8
	sw $t4,  0($t0)
	add $t0, $t0, 116
	sw $t4,  0($t0)
	add $t0, $t0, 8
	sw $t4,  0($t0)
	add $t0, $t0, 8
	sw $t4,  0($t0)
	add $t0, $t0, 112
	sw $t4,  0($t0)
	add $t0, $t0, 16
	sw $t4,  0($t0)
	add $t0, $t0, 116
	sw $t4,  0($t0)
	add $t0, $t0, 8
	sw $t4,  0($t0)
	add $t0, $t0, 124
	sw $t4,  0($t0)
	addi $t3, $t3, 1
	add $t0, $t0, -492
	beq $t3, 1, heart # Draw second heart
	beq $t3, 2, heart # Draw third heart

################################################

	# Set delay for ball movement
	# 50,000 - 100,000 works well for me, but it might not suit all devices
	# Please increase/decrease the value below if the game is too fast/slow
	li $s4, 50000 

game_loop:

	# Check if key has been pressed
	lw $t0, ADDR_KBRD
	lw $t1, 0 ($t0) # load first letter from keyboard
	
	# Check which key has been pressed
	beq $t1, 1 , keyboard_input


	# Reset time counter
	li $t9, 0
	
	# Update ball's location
	ball_move:

		# Prevents rest of code from running until timer is up
		add $t9, $t9, 1
		ble $t9, $s4, ball_move
		
		li $t9, 0	# reset counter
	
		lw $t0, ball	# $t0 = ball address
		lw $s3, black	# $s3 = black
	
		sw $s3, 0($t0)	# makes current pixel on $t0 black 
		
		### Calculate next pixel in ball's trajectory
		
		lw $t7, ball_vx	# load ball's V_x to $t7
		lw $t8, ball_vy	# load ball's V_y to $t8
	
		mul $t1, $t7, 4		# multiply V_x by 4 to find displacement $t1
		add $t0, $t0, $t1	# add displacement $t1 to $t0
	
		mul $t1, $t8, 128	# multiply V_y by 128 to find displacement $t1
		add $t0, $t0, $t1	# add displacement $t1 to $t0 --> next pixel in trajectory
		
		###
	
		# Record loss of life if next pixel in trajectory goes past lower bound of display
		lw $t6, addr_lower_bound
		bge $t0, $t6, lose_heart 
		
		# Check if next pixel is a breakable brick if it is not black
		lw $t2, 0($t0)
		bne $s3, $t2, breaker
		
		# Otherwise, draw ball in next pixel in trajectory
		lw $s1, white
		sw $s1, 0($t0)
		sw $t0, ball # store new position in memory
		
	
	continue:
	
	# Sleep
	li $v0, 32
	li $a0, 10
	syscall

   	# Go back to start of the game loop
    	b game_loop

breaker:
	
	lw $s0, white	
	lw $t2, 0($t0)
	beq $s0, $t2, sound_border_collision # if next pixel in trajectory is white, make the respective sound
	beq $s0, $t2, conflict_response # if next pixel in trajectory is white, calculate response to conflict
	
	# Otherwise, make next pixel in trajectory black
	lw $s3, black
	sw $s3, 0($t0)
	
	### Find pixels neighbouring next pixel in trajectory
	
	# Find pixel on top/under current pixel --> to the left/right of next pixel in trajectory
	neg $t7, $t7
	mul $t7, $t7, 4
	add $t7, $t7, $t0
	
	# Do not break it if it is white
	lw $t2, 0($t7)
	beq $t2, $s0, skip_break1
	
	# Break it if it is not white
	sw $s3, 0($t7)

	skip_break1:
	
	# Find pixel to the left/right of current pixel --> on top/under next pixel in trajectory
	neg $t8, $t8
	mul $t8, $t8, 128
	add $t8, $t8, $t0
	
	# Do not break it if it is white
	lw $t5, 0($t7)
	beq $t5, $s0, skip_break2
	
	# Break it if it is not white
	sw $s3, 0($t8)
	
	skip_break2:
	
	# Produce breaking sound
	li $a0, 80 	# set pitch  
 	li $a1, 500	# set duration (ms) 
  	li $a2, 100     # set MIDI sound
 	li $a3, 100     # set volume
  	li $v0, 31      # set to MIDI out system call
  	syscall
	
	# if pixel is not white call conflict dealer after
	b conflict_response
	
sound_border_collision:
	li $a0, 76     # set pitch  
 	li $a1, 250    # set duration (ms) 
  	li $a2, 85     # set MIDI sound
 	li $a3, 100    # set a moderate volume [0-127]
  	li $v0, 31     # set to MIDI out system call
  	syscall

conflict_response:

	lw $t1, ball_vx # load ball's V_x
	lw $t2, ball_vy # load ball's V_y
	
	neg $t1, $t1 # switch V_x sign
	mul $t1,  $t1, 8 # calculate possible x displacement

	add $t3, $t0, $t1 # find possible ball position $t3 (after x displacement)
	lw $t5, 0($t3) # find colour at this position --> $t5
	
	neg $t2, $t2 # switch V_x sign
	mul $t2, $t2, 256 # calculate possible y displacement

	add $t4, $t0, $t2 # find possible ball position $t4 (after x displacement)
	lw $t6, 0($t4) # find colour at this position --> $t6
	
	lw $s3, black
	beq $t5, $s3, change_vx # switch sign of ball's V_x if position after x displacement is free
	beq $t6, $s3, change_vy # switch sign of ball's V_y if position after y displacement is free
	b corner_check # otherwise, check if it is in a corner
	
change_vx:
	lw $t0, ball_vx	# load ball's V_x
	neg $t0, $t0 # switch V_x sign
	sw $t0, ball_vx # store new value in memory
	
	beq $t6, $s3, change_vy # switch sign of ball's V_y if position after y displacement is free
	bne $ra, $zero, jump_to_ra # jump to $ra if it is not empty
	b continue # continue game loop
	
# Use the following label after checking if $ra is empty to avoid redundant labels
jump_to_ra:
	jr $ra # jump to $ra

change_vy:
	lw $t0, ball_vy # load ball V_y
	neg $t0, $t0 # switch V_y sign
	sw $t0, ball_vy # store new value in memory
	b continue # continue game loop

corner_check:

	# Check difference of colours in possible directions
	neg $t5, $t5
	add $t2, $t5, $t6 
	
	 # If $t5 is not black, calculate reaction to corner
	 bne $t2, $t6, corner_response
	 
	 # Check difference of colours in possible directions
	 neg $t5, $t5
	 neg $t6, $t6
	 
	 # If $t6 is not black, calculate reaction to corner
	 bne $t2, $t5, corner_response
	 
	# otherwise, continue on game_loop
	b continue
	
corner_response:
	jal change_vx	# change V_x sign
	move $ra, $zero	# reset register $ra
	j change_vy	# change V_y sign

lose_heart:

	lw $t8, hearts		# load current number of hears
	add $t8, $t8, -1	# decrease hearts by 1
	sw, $t8, hearts		# store new amount of hearts to memory
	
	# Produce death sound
	li $a0, 60	# set pitch  
 	li $a1, 350     # set duration (ms)
  	li $a2, 85      # set MIDI sound
 	li $a3, 100     # set volume
  	li $v0, 31      # set to MIDI out system call
  	syscall
  	
  	### Erase hearts after life is lost
  	beq $t8, 2, hearts_2		# Erase 1st heart
  	beq $t8, 1, hearts_1		# Erase 2nd heart
  	beq $t8, $zero, hearts_0	# Erase 3rd heart
  	###
  	
  	hearts_2: # Erase 1st heart
  		lw $t0, ADDR_DSPL
  		lw $s6, white
  		add $t0, $t0, 184
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 8($t0)
  		sw $s6, 16($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 16($t0)
  		add $t0, $t0, 128
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		add $t0, $t0, 128
  		sw $s6, 8($t0)
  		j reset_ball
  	
  	hearts_1: # Erase 2nd heart
  		lw $t0, ADDR_DSPL	
  		lw $s6, white
  		add $t0, $t0, 160
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 8($t0)
  		sw $s6, 16($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 16($t0)
  		add $t0, $t0, 128
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		add $t0, $t0, 128
  		sw $s6, 8($t0)
  		j reset_ball
  	
  	hearts_0: # Erase 3rd heart
  		lw $t0, ADDR_DSPL
  		lw $s6, white
  		add $t0, $t0, 136
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 8($t0)
  		sw $s6, 16($t0)
  		
  		add $t0, $t0, 128
  		sw $s6, 0($t0)
  		sw $s6, 16($t0)
  		add $t0, $t0, 128
  		sw $s6, 4($t0)
  		sw $s6, 12($t0)
  		add $t0, $t0, 128
  		sw $s6, 8($t0)
  		
  		# Draw game over screen once player has no hearts left
		j game_over
	
	reset_ball:
		lw $t0, ADDR_DSPL	# load the base address for display to $t0
		add $t0, $t0, 1544	# set $t0 to initial ball's position
		sw $t0, ball		# store position in memory
		
		# Reset ball's velocities to 1
		li $t0, 1
		sw $t0, ball_vx
		sw $t0, ball_vy
		
		# Return to $ra if it is not empty (this is used when restarting the game)
		bne $ra, $zero, jump_to_ra
		b game_loop
		
keyboard_input:
	lw $a1 , 4($t0) # load second word from keyboard
	lw $s0, white # $s0 =  white
	lw $s1, black # $s1 = black
	beq $a1, 0x61, move_left # if a was pressed, move lower paddle left
	beq $a1, 0x64, move_right # if d was pressed, move lower paddle right
	beq $a1, 0x6A, move_left2 # if j was pressed, move upper paddle left
	beq $a1, 0x6C, move_right2 # if l was pressed, move upper paddle right
	beq $a1, 0x70, pause # if p was pressed, pause game
	beq $a1, 0x68, switch_to_hardmode # if h was pressed, switch to hardmode
	beq $a1, 0x72, restart # if r was pressed, restart game
	b game_loop
	
move_left:
	lw $t2, paddle_l # load address to start of paddle
	add $t2, $t2, -4 # move a pixel to the left
	lw $t1, 0($t2)
	
	beq $s0, $t1, game_loop # if the pixel is white, do not move paddle
	
	sw $t2, paddle_l # save new left end of paddle to paddle_l
	sw $s0, 0($t2) # draw new white pixel
	
	lw $t2, paddle_r # load address to right end of paddle
	sw $s1, 0($t2) # draw new black pixel
	
	add $t2, $t2, -4 # move a pixel to the left 
	sw $t2, paddle_r # save new right end of paddle
	
	b game_loop

move_right:
	lw $t2, paddle_r # load address to end of paddle
	add $t2, $t2, 4 # move a pixel to the right
	lw $t1, 0($t2)
	
	beq $s0, $t1, game_loop # if new pixel is white, do not move paddle
	
	sw $t2, paddle_r # save new right end of paddle to paddle_r
	sw $s0, 0($t2) # draw new white pixel
	
	lw $t2, paddle_l # load address to end of paddle
	
	sw $s1, 0($t2) # draw new black pixel
	add $t2, $t2, 4 # move a pixel to the left 

	sw $t2, paddle_l # save new left end of paddle
	b game_loop
	
move_left2:
	lw $t2, paddle_l2 # load address to start of paddle
	add $t2, $t2, -4 # move a pixel to the left
	lw $t1, 0($t2)
	
	beq $s0, $t1, game_loop # if new pixel is white, do not move paddle
	
	sw $t2, paddle_l2 # save new left end of paddle to paddle_l
	sw $s0, 0($t2) # draw new white pixel
	
	lw $t2, paddle_r2 # load address to right end of paddle

	sw $s1, 0($t2) # draw new black pixel
	
	add $t2, $t2, -4 # move a pixel to the left 
	sw $t2, paddle_r2 # save new right end of paddle
	
	b game_loop

move_right2:
	lw $t2, paddle_r2 # load address to end of paddle
	add $t2, $t2, 4 # move a pixel to the right
	lw $t1, 0($t2)
	
	beq $s0, $t1, game_loop # if new pixel is whitem do not move paddle
	
	sw $t2, paddle_r2 # save new end of right paddle to paddle_r
	sw $s0, 0($t2) # draw new white pixel
	
	lw $t2, paddle_l2 # load address to end of paddle
	
	sw $s1, 0($t2) # draw new black pixel
	add $t2, $t2, 4 # move a pixel to the left 

	sw $t2, paddle_l2 # save new left end of paddle
	b game_loop

pause:
	# Waits for keyboard input
	lw $t0, ADDR_KBRD
	lw $t1, 0 ($t0) # load first letter from keyboard
	beq $t1, 1 , keyboard_input # unpauses game after new input
	b pause
	
switch_to_hardmode:

	# Draw skull on top border
	lw $t0, ADDR_DSPL	# load the base address for display to $t0
	add $t0, $t0, 228
	lw $t3, red
	sw $t3, 0($t0)
	sw $t3, 4($t0)
	sw $t3, 8($t0)
	add $t0, $t0, 124
	sw $t3, 0($t0)
	sw $t3, 4($t0)
	sw $t3, 8($t0)
	sw $t3, 12($t0)
	sw $t3, 16($t0)
	add $t0, $t0, 128
	sw $t3, 0($t0)
	sw $t3, 8($t0)
	sw $t3, 16($t0)
	add $t0, $t0, 128
	sw $t3, 0($t0)
	sw $t3, 4($t0)
	sw $t3, 12($t0)
	sw $t3, 16($t0)
	add $t0, $t0, 128
	sw $t3, 4($t0)
	sw $t3, 8($t0)
	sw $t3, 12($t0)
	lw $t3, white
	add $t0, $t0, 168
	sw $t3, 0($t0)
	sw $t3, 108($t0)
	add $t0, $t0, 128
	sw $t3, 4($t0)
	sw $t3, 104($t0)
	add $t0, $t0, 128
	sw $t3, 8($t0)
	sw $t3, 100($t0)
	add $t0, $t0, 128
	sw $t3, 12($t0)
	sw $t3, 96($t0)
	add $t0, $t0, 128
	sw $t3, 16($t0)
	sw $t3, 92($t0)

	add $s4, $s4, -2000 # Speed up ball movement
	
	b game_loop
	
game_over:

	# Draw "OVER" sign
	lw $s4, white
	lw $t0, ADDR_DSPL
	add $t0, $t0, 1948
	sw $s4, 0($t0)
	sw $s4, 4($t0)
	sw $s4, 8($t0)
	
	sw $s4, 20($t0)
	sw $s4, 28($t0)
	
	sw $s4, 40($t0)
	sw $s4, 44($t0)
	sw $s4, 48($t0)
	
	sw $s4, 60($t0)
	sw $s4, 64($t0)
	sw $s4, 68($t0)
	
	add $t0, $t0, 128
	
	sw $s4, 0($t0)
	sw $s4, 8($t0)
	
	sw $s4, 20($t0)
	sw $s4, 28($t0)
	
	sw $s4, 40($t0)
	
	sw $s4, 60($t0)
	sw $s4, 68($t0)
	
	add $t0, $t0, 128
	
	sw $s4, 0($t0)
	sw $s4, 8($t0)
	
	sw $s4, 20($t0)
	sw $s4, 28($t0)
	
	sw $s4, 40($t0)
	sw $s4, 44($t0)
	sw $s4, 48($t0)
	
	sw $s4, 60($t0)
	sw $s4, 64($t0)
	
	add $t0, $t0, 128
	
	sw $s4, 0($t0)
	sw $s4, 8($t0)
	
	sw $s4, 20($t0)
	sw $s4, 28($t0)
	
	sw $s4, 40($t0)
	sw $s4, 8($t0)
	
	sw $s4, 60($t0)
	sw $s4, 68($t0)
	
	add $t0, $t0, 128
	
	sw $s4, 0($t0)
	sw $s4, 4($t0)
	sw $s4, 8($t0)
	
	sw $s4, 24($t0)
	
	sw $s4, 40($t0)
	sw $s4, 44($t0)
	sw $s4, 48($t0)
	
	sw $s4, 60($t0)
	sw $s4, 68($t0)
	
	# Loop to check when player wants to restart
	check_for_retry:
		
		# Check if key has been pressed
		lw $t0, ADDR_KBRD
		lw $t1, 0 ($t0) # Load first letter from keyboard
		
		# Check which key has been pressed
		beq $t1, 1 , keyboard_input
	b check_for_retry

restart:
	jal reset_ball # resets ball's position
	move $ra, $zero # resets $ra register
	
	# Reset number of hearts to 3
	li $t6, 3 
	sw $t6, hearts # store in memory
	
	b main
	
	
	

# Bitmap display starter code
#
# CSCB58 Final Project Game
# Vraj Shah, 1009102695, shahvra8

# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 512
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#

.eqv BASE_ADDRESS 0x10008000
.eqv startingPosition $s0
.eqv healthPoints $s1
.eqv PlatPos2 $s2
.eqv shotPos $s6
.eqv platPos $s4
.eqv SLEEP 100

.data
screensize: .word 1024
sleep: .word 100

#Colours
black: .word 0x000000
blue: .word 0x0000FF
red: .word 0xFF0000
orange: .word 0xFFA500
green: .word 0x008000
skin: .word 0xe0ac69
lavender: .word 0xE6E6FA
pink: .word 0xFFB6C1 
brown: .word 0x964B00
silver: .word 0xC0C0C0
gold: .word 0xFFD700
neonOrange: .word 0xFF5F1F
lightGreen: .word 0x90EE90


.globl main
.text

#Initializing a bunch of values for
addi startingPosition, startingPosition,15368
li healthPoints,2
li shotPos, 10680
li platPos, 8960
li PlatPos2,7896

main:
    
    jal drawCharacter
    jal drawFirstPlatform
    jal drawFirstObject
    jal drawCoin
    jal drawSecondPlatform
    jal drawThirdPlatform
    jal drawFourthPlatform
    jal drawFifthPlatform
    jal drawSpikes
    jal drawMovingPlat
    jal drawMovingPlat2
    jal drawWinBox
    jal hpCheck
    jal drawEnemyShot
    #jal shotCollision1
    #jal coinCollision
    #jal winBoxCollision
    #jal spikeCollision
     
    li $v0, 32 
    li $a0, SLEEP
    syscall
    
    jal keyBoardInput
    jal movingCollision
    jal shotCollision1
    jal coinCollision
    jal winBoxCollision
    jal spikeCollision
    
    j main
     

drawCharacter:	
    addi $s5, startingPosition , BASE_ADDRESS
    lw $t0, skin
    sw $t0, 0($s5)
    sw $t0, 260($s5)
    sw $t0, 252($s5)
    lw $t0, green
    sw $t0, 256($s5)
    lw $t0, blue
    sw $t0, 512($s5) 
    sw $t0, 768($s5)
    jr $ra
  
    
drawFirstPlatform:
   li $t5, 13860
   addi $t4,$t5, BASE_ADDRESS
   lw $t0, pink
   sw $t0, 0($t4)
   sw $t0, 4($t4)
   sw $t0, 8($t4)
   sw $t0, 12($t4)
   sw $t0, 16($t4)
   sw $t0, 20($t4)
   sw $t0, 24($t4)
   sw $t0, 28($t4)
   jr $ra
   
drawFirstObject:
   addi $s3, $zero, BASE_ADDRESS
   lw $t0, red
   sw $t0, 13404($s3)
   sw $t0, 13660($s3)
   sw $t0, 13148($s3)
   sw $t0, 12892($s3)
   sw $t0, 13916($s3)
   sw $t0, 13916($s3)
   sw $t0, 14172($s3)
   lw $t0, silver
   sw $t0, 13656($s3)
   sw $t0, 13144($s3)
   sw $t0, 13400($s3)
   sw $t0, 13396($s3)
   jr $ra


	
drawCoin:
   addi $t3, $zero, BASE_ADDRESS
   lw $t0, gold
   sw $t0, 11380($t3)
   sw $t0, 11384($t3)
   sw $t0, 11636($t3)
   sw $t0, 11640($t3)
   
   jr $ra

drawSecondPlatform:
   addi $t3, $zero, BASE_ADDRESS 
   lw $t0, pink
   sw $t0, 12940($t3)
   sw $t0, 12944($t3)
   sw $t0, 12948($t3)
   sw $t0, 12952($t3)
   sw $t0, 12956($t3)
   jr $ra
   
drawThirdPlatform:
   addi $s3, $zero, BASE_ADDRESS 
   lw $t0, pink
   sw $t0, 11444($s3)
   sw $t0, 11448($s3)
   sw $t0, 11452($s3)
   sw $t0, 11456($s3)
   sw $t0, 11460($s3)
   
   lw $t0, orange
   sw $t0, 11196($s3)
   sw $t0, 10940($s3)
   sw $t0, 10684($s3)
   sw $t0, 10428($s3)
   
   jr $ra
   
drawFourthPlatform:
   addi $t2, $zero, BASE_ADDRESS
   lw $t0, pink
   sw $t0, 7392($t2)
   sw $t0, 7388($t2)
   sw $t0, 7396($t2)
   sw $t0, 7400($t2)
   sw $t0, 7384($t2)
   sw $t0, 7380($t2)
   jr $ra
   
 drawFifthPlatform:
   addi $t2, $zero, BASE_ADDRESS
   lw $t0, pink
   sw $t0, 5560($t2)
   sw $t0, 5556($t2)
   sw $t0, 5552($t2)
   sw $t0, 5548($t2)
   sw $t0, 5544($t2)
   sw $t0, 5540($t2)
   jr $ra
   
drawMovingPlat:
	li $t3, 0x000000
	addi $t7,platPos, BASE_ADDRESS
	sw $t3, 0($t7)
	sw $t3, 4($t7)
	sw $t3, 8($t7)
	sw $t3,12($t7)
	sw $t3,16($t7)
	sw $t3,20($t7)

	addi platPos,platPos,4
	bge platPos,9216,resetPlat
	addi $s7,platPos,BASE_ADDRESS
	
	li $t0, 0xFFB6C1
	sw $t0,0($s7)
	sw $t0,4($s7)
	sw $t0,8($s7)
	sw $t0,12($s7)
	sw $t0,16($s7)
	sw $t0,20($s7)
	jr $ra


resetPlat:
	li $t1, 0x000000
	li $t2,0
	addi $t2,$zero,BASE_ADDRESS
	addi $t2,$t2,9216
	sw $t1,0($t2)
	sw $t1,4($t2)
	sw $t1,8($t2)
	sw $t3,12($t7)
	sw $t3,16($t7)
	sw $t3,20($t7)
	#li $s7, 0
	li platPos,8960
	jr $ra
	
drawMovingPlat2:
	li $t3, 0x000000
	li $t7, 0
	addi $t7,PlatPos2, BASE_ADDRESS
	sw $t3, 0($t7)
	sw $t3, 4($t7)
	sw $t3, 8($t7)
	sw $t3,12($t7)
	sw $t3,16($t7)
	sw $t3,20($t7)

	addi PlatPos2,PlatPos2,4
	bge PlatPos2,8152,resetPlat2
	#li $t7, 0
	addi $t7,PlatPos2,BASE_ADDRESS
	
	li $t0, 0xFFB6C1
	sw $t0,0($t7)
	sw $t0,4($t7)
	sw $t0,8($t7)
	sw $t0,12($t7)
	sw $t0,16($t7)
	sw $t0,20($t7)
	jr $ra


resetPlat2:
	li $t1, 0x000000
	li $t2,0
	addi $t2,$zero,BASE_ADDRESS
	addi $t2,$t2,8152
	sw $t1,0($t2)
	sw $t1,4($t2)
	sw $t1,8($t2)
	sw $t3,12($t7)
	sw $t3,16($t7)
	sw $t3,20($t7)
	#li $s7, 0
	li PlatPos2,7896
	jr $ra
	
winBoxCollision:
       lw $t0, neonOrange
       lw $t2, 768($s5)
       bne $t2, $t0, keyPressDone
       j winScreen
       	
movingCollision:
	bge startingPosition, platPos, biggerThanLeft
	j collisionFound#
	
biggerThanLeft:
	addi $t2, platPos,20
	ble startingPosition, $t2, keyPressDone
	j collisionFound##
	
hpCheck:
	beq healthPoints,1,drawHealth1
	bge healthPoints,2,drawHealth2
	li $t8, 0
	beq healthPoints,0,render_lose

drawHealth1:
	lw $t1, green
	li $t0, 0x000000
	li $t8, 0
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 4
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 8
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 0
	sw $t1, BASE_ADDRESS($t8)
	jr $ra
drawHealth2:
	lw $t1, green
	li $t0, 0x000000
	li $t8, 0
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 4
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 8
	sw $t0, BASE_ADDRESS($t8)
	li $t8, 0
	sw $t1, BASE_ADDRESS($t8)
	li $t8, 4
	sw $t1, BASE_ADDRESS($t8)
	jr $ra
drawEnemyShot:
	li $t3, 0x000000
	addi $s7,shotPos, BASE_ADDRESS
	sw $t3, 0($s7)
	
	#j enemyShotMove
	addi shotPos,shotPos,-4
	beq shotPos, 10496, resetEnemyShot
	addi $s7,shotPos,BASE_ADDRESS
	
	li $t0, 0xff0000
	sw $t0,0($s7)
	jr $ra
shotCollision1:
	li $t0, 0xff0000
	lw $t2,0($s5)
	beq $t2,$t0,subtractHealth
	lw $t2,256($s5)
	beq $t2,$t0,subtractHealth
	lw $t2,512($s5)
	beq $t2,$t0,subtractHealth
	lw $t2,768($s5)
	beq $t2,$t0,subtractHealth
	
	jr $ra
	
coinCollision:
	li $t0, 0xFFD700
	lw $t2,768($s5)
	bne $t2,$t0,keyPressDone
	beq healthPoints,1,addHealth
	jr $ra	
	
resetEnemyShot:
	li shotPos, 10680
	#bge plat_pos,8692,reset_plat1
	
drawSpikes:
   addi $s3, $zero, BASE_ADDRESS
   lw $t0, silver
   sw $t0, 16240($s3)
   sw $t0, 16244($s3)
   sw $t0, 16248($s3)
   sw $t0, 16252($s3)
   sw $t0, 16256($s3)
   sw $t0, 15992($s3)
   sw $t0, 15996($s3)
   sw $t0, 15988($s3)
   sw $t0, 15736($s3)
   
   sw $t0, 16224($s3)
   sw $t0, 16220($s3)
   sw $t0, 16216($s3)
   sw $t0, 16212($s3)
   sw $t0, 16208($s3)
   sw $t0, 15956($s3)
   sw $t0, 15960($s3)
   sw $t0, 15964($s3)
   sw $t0, 15704($s3)
   
   sw $t0, 16192($s3)
   sw $t0, 16188($s3)
   sw $t0, 16184($s3)
   sw $t0, 16180($s3)
   sw $t0, 16176($s3)
   sw $t0, 15928($s3)
   sw $t0, 15924($s3)
   sw $t0, 15932($s3)
   sw $t0, 15672($s3)
   
   sw $t0, 16272($s3)
   sw $t0, 16276($s3)
   sw $t0, 16280($s3)
   sw $t0, 16284($s3)
   sw $t0, 16288($s3)
   sw $t0, 16024($s3)
   sw $t0, 16020($s3)
   sw $t0, 16028($s3)
   sw $t0, 15768($s3)
   
   sw $t0, 16304($s3)
   sw $t0, 16308($s3)
   sw $t0, 16312($s3)
   sw $t0, 16316($s3)
   sw $t0, 16320($s3)
   sw $t0, 16056($s3)
   sw $t0, 16060($s3)
   sw $t0, 16052($s3)
   sw $t0, 15800($s3)
   
   jr $ra
   
   
spikeCollision:#####
	lw $t0, silver
	lw $t2, 768($s5)
	bne $t2,$t0,keyPressDone
	j render_lose

addHealth:
	addi healthPoints,healthPoints,1
	jr $ra
subtractHealth:
	sub healthPoints, healthPoints,1
	jr $ra
render_lose:#####
	li $t9, 16380
	lw $t0, red
	li $t4,0

   	sw $t0, BASE_ADDRESS($t8) 
    	addi $t8,$t8,4
    	ble $t8,$t9,render_lose
    	
    	addi $t8, $zero, BASE_ADDRESS
    	lw $t0, silver
    	
    	sw $t0, 5168($t8)
    	sw $t0, 5424($t8)
    	sw $t0, 5680($t8)
    	sw $t0, 5936($t8)
    	sw $t0, 6192($t8)
    	sw $t0, 6448($t8)
    	sw $t0, 6452($t8)
    	sw $t0, 6456($t8)
    	sw $t0, 6460($t8)
    	sw $t0, 6464($t8)
    	sw $t0, 6468($t8)
    	sw $t0, 6212($t8)
    	sw $t0, 5956($t8)
    	sw $t0, 5700($t8)
    	sw $t0, 5444($t8)
    	sw $t0, 5188($t8)
    	sw $t0, 6724($t8)
    	sw $t0, 6980($t8)
    	sw $t0, 7236($t8)
    	sw $t0, 7492($t8)
    	sw $t0, 7748($t8)
    	sw $t0, 7744($t8)
    	sw $t0, 7740($t8)
    	sw $t0, 7736($t8)
    	sw $t0, 7732($t8)
    	sw $t0, 7728($t8)
    	
    	#Letter O
    	
    	sw $t0, 7768($t8)
    	sw $t0, 7772($t8)
    	sw $t0, 7776($t8)
    	sw $t0, 7780($t8)
    	sw $t0, 7784($t8)
    	sw $t0, 7788($t8)
    	sw $t0, 7792($t8)
    	sw $t0, 7512($t8)
    	sw $t0, 7256($t8)
    	sw $t0, 7000($t8)
    	sw $t0, 6744($t8)
    	sw $t0, 6488($t8)
    	sw $t0, 6232($t8)
    	sw $t0, 5976($t8)
    	sw $t0, 5720($t8)
    	sw $t0, 5464($t8)
    	sw $t0, 5208($t8)
    	sw $t0, 7536($t8)
    	sw $t0, 7280($t8)
    	sw $t0, 7024($t8)
    	sw $t0, 6768($t8)
    	sw $t0, 6512($t8)
    	sw $t0, 6256($t8)
    	sw $t0, 6000($t8)
    	sw $t0, 5744($t8)
    	sw $t0, 5488($t8)
    	sw $t0, 5232($t8)
    	sw $t0, 5228($t8)
    	sw $t0, 5224($t8)
    	sw $t0, 5220($t8)
    	sw $t0, 5216($t8)
    	sw $t0, 5212($t8)
    	sw $t0, 5208($t8)
    	
    	# Letter U
    	
    	sw $t0, 5252($t8)
    	sw $t0, 5508($t8)
    	sw $t0, 5764($t8)
    	sw $t0, 6020($t8)
    	sw $t0, 6276($t8)
    	sw $t0, 6532($t8)
    	sw $t0, 6788($t8)
    	sw $t0, 7044($t8)
    	sw $t0, 7300($t8)
    	sw $t0, 7556($t8)
    	sw $t0, 7812($t8)
    	sw $t0, 7816($t8)
    	sw $t0, 7820($t8)
    	sw $t0, 7824($t8)
    	sw $t0, 7828($t8)
    	sw $t0, 7832($t8)
    	sw $t0, 7836($t8)
    	sw $t0, 7580($t8)
    	sw $t0, 7324($t8)
    	sw $t0, 7068($t8)
    	sw $t0, 6812($t8)
    	sw $t0, 6556($t8)
        sw $t0, 6300($t8)
    	sw $t0, 6044($t8)
    	sw $t0, 5788($t8)
    	sw $t0, 5532($t8)
    	sw $t0, 5276($t8)
    	
    	#Letter L
    	
    	sw $t0, 8984($t8)
    	sw $t0, 9240($t8)
    	sw $t0, 9496($t8)
    	sw $t0, 9752($t8)
    	sw $t0, 10008($t8)
    	sw $t0, 10264($t8)
    	sw $t0, 10520($t8)
        sw $t0, 10776($t8)
        sw $t0, 11032($t8)
        sw $t0, 11036($t8)
        sw $t0, 11040($t8)
        sw $t0, 11044($t8)
        sw $t0, 11048($t8)
        sw $t0, 11052($t8)
        sw $t0, 11056($t8)
        
        #Letter O
        sw $t0, 11072($t8)
        sw $t0, 10816($t8)
        sw $t0, 10560($t8)
        sw $t0, 10304($t8)
        sw $t0, 10048($t8)
        sw $t0, 9792($t8)
        sw $t0, 9536($t8)
        sw $t0, 9280($t8)
        sw $t0, 9024($t8)
        sw $t0, 11076($t8)
        sw $t0, 11080($t8)
        sw $t0, 11084($t8)
        sw $t0, 11088($t8)
        sw $t0, 11092($t8)
        sw $t0, 11096($t8)
        sw $t0, 9028($t8)
        sw $t0, 9032($t8)
        sw $t0, 9036($t8)
        sw $t0, 9040($t8)
        sw $t0, 9044($t8)
        sw $t0, 9048($t8)
        sw $t0, 9304($t8)
        sw $t0, 9560($t8)
        sw $t0, 9816($t8)
        sw $t0, 10072($t8)
        sw $t0, 10328($t8)
        sw $t0, 10584($t8)
        sw $t0, 10840($t8)
        sw $t0, 11096($t8)
        
        #Letter S
        
        sw $t0, 9064($t8)
        sw $t0, 9068($t8)
        sw $t0, 9072($t8)
        sw $t0, 9076($t8)
        sw $t0, 9080($t8)
        sw $t0, 9084($t8)
        sw $t0, 9320($t8)
        sw $t0, 9576($t8)
        sw $t0, 9832($t8)
        sw $t0, 10088($t8)
        sw $t0, 10092($t8)
        sw $t0, 10096($t8)
        sw $t0, 10100($t8)
        sw $t0, 10104($t8)
        sw $t0, 10108($t8)
        sw $t0, 10364($t8)
        sw $t0, 10620($t8)
        sw $t0, 10876($t8)
        sw $t0, 11132($t8)
        sw $t0, 11128($t8)
        sw $t0, 11124($t8)
        sw $t0, 11120($t8)
        sw $t0, 11116($t8)
        sw $t0, 11112($t8)
        
        #Letter E
        
        sw $t0, 11148($t8)
        sw $t0, 11152($t8)
        sw $t0, 11156($t8)
        sw $t0, 11160($t8)
        sw $t0, 11164($t8)
        sw $t0, 11168($t8)
        
        sw $t0, 10892($t8)
        sw $t0, 10636($t8)
        sw $t0, 10380($t8)
        sw $t0, 10124($t8)
        sw $t0, 10128($t8)
        sw $t0, 10132($t8)
        sw $t0, 10136($t8)
        sw $t0, 10140($t8)
        sw $t0, 10144($t8)
        
        sw $t0, 9868($t8)
        sw $t0, 9612($t8)
        sw $t0, 9356($t8)
        sw $t0, 9100($t8)
        
        sw $t0, 9104($t8)
        sw $t0, 9108($t8)
        sw $t0, 9112($t8)
        sw $t0, 9116($t8)
        sw $t0, 9120($t8)
        
	li $v0, 10
    	syscall
   
drawWinBox:
	addi $t1, $zero, BASE_ADDRESS
	lw $t0, neonOrange
	sw $t0, 2872($t1)
	sw $t0, 2868($t1)
	sw $t0, 2864($t1)
	sw $t0, 2860($t1)
	sw $t0, 2856($t1)
	sw $t0, 2852($t1)
	sw $t0, 2596($t1)
	sw $t0, 2340($t1)
	sw $t0, 2616($t1)
	sw $t0, 2360($t1)
	
	jr $ra


winScreen:
	li $t9, 16384
	lw $t0, lightGreen
	li $t4,0

   	sw $t0, BASE_ADDRESS($t8) 
    	addi $t8,$t8,4
    	ble $t8,$t9, winScreen
    	
    	addi $t8, $zero, BASE_ADDRESS
    	lw $t0, gold
    	sw $t0, 5180($t8)
    	sw $t0, 5436($t8)
    	sw $t0, 5692($t8)
    	sw $t0, 5948($t8)
    	sw $t0, 6204($t8)
    	sw $t0, 6460($t8)
    	sw $t0, 6716($t8)
    	sw $t0, 6972($t8)
    	sw $t0, 7228($t8)
    	sw $t0, 7484($t8)
    	sw $t0, 7740($t8)
    	
    	sw $t0, 7488($t8)
    	sw $t0, 7236($t8)
    	sw $t0, 6984($t8)
    	sw $t0, 6732($t8)
    	sw $t0, 6992($t8)
    	sw $t0, 7252($t8)
    	sw $t0, 7512($t8)
    	sw $t0, 7772($t8)
    	
    	sw $t0, 7516($t8)
    	sw $t0, 7260($t8)
    	sw $t0, 7004($t8)
    	sw $t0, 6748($t8)
    	sw $t0, 6492($t8)
    	sw $t0, 6236($t8)
    	sw $t0, 5980($t8)
    	sw $t0, 5724($t8)
    	sw $t0, 5468($t8)
    	sw $t0, 5212($t8)
    	
    	sw $t0, 5228($t8)
    	sw $t0, 5484($t8)
    	sw $t0, 5740($t8)
    	sw $t0, 5996($t8)
    	sw $t0, 6252($t8)
    	sw $t0, 6508($t8)
    	sw $t0, 6764($t8)
    	sw $t0, 7020($t8)
    	sw $t0, 7788($t8)
    	
    	li $v0, 10
    	syscall
	
keyBoardInput:
   li $t9, 0xffff0000
   lw $t8, 0($t9)
   bne $t8, 1, keyPressDone
   lw $t2, 4($t9)
  # beq $t2, 0x20, spaceBar #To jump
   beq $t2, 0x61, leftKey # a is the left key to move left
   beq $t2, 0x64, rightKey # d is the right key to move right
   beq $t2, 0x77, jumpKey # w is the jump key to jump
   beq $t2, 0x70, restartKey # p is the restart game key
   j keyPressDone
 
 leftKey:
   lw $t1, black
   sw $t1, 0($s5)
   sw $t1, 256($s5)
   sw $t1, 512($s5)
   sw $t1, 252($s5)
   sw $t1, 260($s5)
   sw $t1, 768($s5)
   subi $s5, $s5, 4
   li $t5, 256
   div $s5, $t5
   mfhi $t6
   beq $t6, 0, keyPressDone
   addi startingPosition, startingPosition, -4
   j keyPressDone

restartKey:
   j restartPosition

restartPosition:
   lw $t1, black
   sw $t1, 0($s5)
   sw $t1, 256($s5)
   sw $t1, 512($s5)
   sw $t1, 252($s5)
   sw $t1, 260($s5)
   sw $t1, 768($s5)
   li startingPosition, 15368
   j keyPressDone
   
   
 rightKey:
 
   lw $t1, black
   sw $t1, 0($s5)
   sw $t1, 256($s5)
   sw $t1, 512($s5)
   sw $t1, 252($s5)
   sw $t1, 260($s5)
   sw $t1, 768($s5)
   li $t5, 256
   addi $s5, $s5, 8
   div $s5, $t5
   mfhi $t6
   beq $t6, 0, keyPressDone
   addi startingPosition, startingPosition, 4
   j keyPressDone
 
 jumpKey: #not working, yet keeps going off the screen
  

   lw $t1, black
   sw $t1, 0($s5)
   sw $t1, 256($s5)
   sw $t1, 512($s5)
   sw $t1, 252($s5)
   sw $t1, 260($s5)
   sw $t1, 768($s5)
   ble startingPosition, 768, keyPressDone
   addi startingPosition, startingPosition, -1024
   j keyPressDone
 
collisionFound:

	li $t0, 0x0000FF
	lw $t2,768($s5)
	bne $t2,$t0,keyPressDone
	j gravity

gravity: #not working properly either
   #addi $s5, startingPosition, BASE_ADDRESS
   lw $t2, black
   sw $t2, 0($s5)
   sw $t2, 256($s5)
   sw $t2, 512($s5)
   sw $t2, 252($s5)
   sw $t2, 260($s5)
   sw $t2, 768($s5)
   bge startingPosition,15328, keyPressDone
   addi startingPosition, startingPosition, 256
   jr $ra
 
keyPressDone:
   jr $ra  
   

   

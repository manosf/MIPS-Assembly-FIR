.data

X:  .word 1, 1, 1, 2, 2, 3, 4, 2, 1, 1, 2, 3, 2, 4, 8, 1
H:  .word 1, 5, 1, 4, 2, 1, 1, 1
Y:  .word 0, 0, 0, 0, 0, 0, 0, 0
m:  .word 8
n:  .word 8


.text

main:

  daddi R1,R0,X
  daddi R2,R0,H
	daddi R3,R0,Y
	daddi R4,R0,m
	lw    R5,0(R4)     	 #m
	daddi R4,R0,n
	lw    R6,0(R4)     	 #n
	daddi R7,R0,0      	 #j=0
	daddi R8,R0,8      	 #k=8

Loop1:
	beq R5, R7, EXIT
	daddi R10,R0,0       #i=0
	daddi R9,R0,0      	 #y0=0


Loop2:
	beq   R6, R10, DONE  #if i=n go to DONE
	dadd  R11,R10,R7     # i+j
	dmul  R12,R11,R8  	 #(i+j)*8
	dmul  R14,R10,R8   	 #i*8
	dadd  R11,R1,R12
	lw    R13,0(R11)   	 #X[i+j]
  dadd  R15,R14,R2
	lw    R16,0(R15)   	 #H[i]
	daddi R10,R10,1	 	   #i+=1
	dmul  R17,R16,R13  	 #X[i+j]*H[i]


	dadd R11,R10,R7      # i+j+1
	dadd  R9,R9,R17    	 #y0+=X[i+j]*H[i]

	dmul  R12,R11,R8  	 #(i+j+1)*8
	dmul  R14,R10,R8   	 #i*8
	dadd  R11,R1,R12
	lw    R20,0(R11)   	 #X[i+j+1]
    dadd  R15,R14,R2
	lw    R16,0(R15)   	 #H[i]
	daddi R10,R10,1	 	   #i+=1
	dmul  R17,R16,R20  	 #X[i+j]*H[i]


	dadd R11,R10,R7      # i+j+1
	dadd  R9,R9,R17    	 #y0+=X[i+j]*H[i]

	dmul  R12,R11,R8  	 #(i+j+2)*8
	dmul  R14,R10,R8   	 #i*8
	dadd  R11,R1,R12
	lw    R21,0(R11)   	 #X[i+j+2]
    dadd  R15,R14,R2
	lw    R16,0(R15)   	 #H[i]
	daddi R10,R10,1	 	 #i+=1
	dmul  R17,R16,R21  	 #X[i+j]*H[i]


	dadd R11,R10,R7      # i+j+1
	dadd  R9,R9,R17    	 #y0+=X[i+j]*H[i]

	dmul  R12,R11,R8  	 #(i+j+3)*8
	dmul  R14,R10,R8   	 #i*8
	dadd  R11,R1,R12
	lw    R22,0(R11)   	 #X[i+j+3]
  dadd  R15,R14,R2
	lw    R16,0(R15)   	 #H[i]
	daddi R10,R10,1	 	   #i+=1
	dmul  R17,R16,R22  	 #X[i+j]*H[i]


	j Loop2
	dadd  R9,R9,R17    	 #y0+=X[i+j]*H[i]

DONE:
	dmul  R18,R7,R8    	 #j*8
	dadd  R19,R18,R3

	daddi R7,R7,1      	 #j++
	j Loop1
	sw    R9,0(R19)    	 #Y[j]=y0

EXIT:
	halt

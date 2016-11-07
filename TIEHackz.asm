; ----------------------------------------------------------- ;
; A TIE FIGHTER c. j�t�k ir�ny�t�sfeljav�t� toolja, by Prenex ;
; Az alap ir�ny�t�s botkorm�ny n�lk�l nagyon gagyi, ezt       ;
; jav�tjuk ki �gy, hogy ne kelljen kalimp�lni akkor�kat :)    ;
; ----------------------------------------------------------- ;

.486
Program Segment Para Use16
	assume cs:Program,ds:Program,ss:Program
org 100h

BONUS		equ 25		;Ut�kit�r�s max m�rt�ke!
SCRWIDTH	equ 320
SCRHEIGHT	equ 200		;A felbont�s

Start:
	jmp Foprogram

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	-=M�dos�tott eg�rdriver=-	;;;
Int33h:
	cmp ax,000Bh
	jnz Normal		;Ha lek�rdezik mennyit mozdult az eg�r
Tricky:
	cmp word ptr cs:[Plusscucc1],0
	jz szarr1
	sub word ptr cs:[Plusscucc1],1
szarr1:
	cmp word ptr cs:[Plusscucc2],0
	jz szarr2
	sub word ptr cs:[Plusscucc2],1
szarr2:
	cmp word ptr cs:[Minuscucc1],0
	jz szarr3
	sub word ptr cs:[Minuscucc1],1
szarr3:
	cmp word ptr cs:[Minuscucc2],0
	jz szarr4
	sub word ptr cs:[Minuscucc2],1
szarr4:				;ez a r�sz is sz�ls�kit�r�skezel�s

	dec word ptr cs:[Counter]
	jz VanMozgas
	mov cx,0		;nem mozdult jelz�s, kiv�ve minden
	mov dx,0		;SENSITIVITY-edik h�v�s!!!
	IRET
VanMozgas:
	mov ax,word ptr cs:[Sensitivity]
	mov word ptr cs:[Counter],ax

	mov ax,0003h		;akkor eredeti int alapj�n megn�zz�k
	call Old33h		;hol a kurzor

	cmp cx,317
	jae foso1
	add word ptr cs:[PlussCucc1],2
foso1:
	cmp cx,2
	jbe foso2
	add word ptr cs:[MinusCucc1],2
foso2:
	cmp dx,197
	jae foso3
	add word ptr cs:[PlussCucc2],2
foso3:
	cmp dx,2
	jbe foso4
	add word ptr cs:[MinusCucc2],2
foso4:				;LEG-sz�ls� kanyarod�s kezel�se!(lentisvan)
	shr cx,1		;+kicsit var�zslunk p�r regiszterrel

	;	pusha
	;mov ax,0cEEh
	;int 10h
	;	popa		;kontrollrajzol�s

	sub cx,SCRWIDTH / 2
	sub dx,SCRHEIGHT / 2	;a kurzorpozicioval emulalunk elmozdulast!

	cmp word ptr cs:[Cuccmok],1
	jz Cuuuc
	sar cx,2
	sar dx,1
Cuuuc:
		push dx
	mov ax,cx
	mov bx,cx
	sar cx,15
	xor ax,cx
	sub ax,cx
	imul bx		;DX:AX <- CX * |CX|
	mov cx,ax	;CX <- CX * |CX|
		pop dx
	mov ax,dx
	mov bx,dx
	sar dx,15
	xor ax,dx
	sub ax,dx
	imul bx		;DX:AX <- DX *  |DX|
	mov dx,ax	;DX <- DX * |DX|

	sar cx,3
	sar dx,3

	cmp cx,100
	jg foss
	cmp cx,-100
	jl foss
	cmp dx,50
	jg foss
	cmp dx,-50
	jl foss
	mov word ptr cs:[Sensitivity],7
	mov word ptr cs:[Cuccmok],1
	jmp kulaqua
foss:
	mov word ptr cs:[Sensitivity],2
	mov word ptr cs:[Cuccmok],0
kulaqua:
	cmp cx,10
	jg kula1
	cmp cx,-10
	jl kula1
	mov cx,0
kula1:
	cmp dx,5
	jg kula2
	cmp dx,-5
	jl kula2
	mov dx,0
kula2:

	cmp word ptr cs:[Plusscucc1],BONUS
	jl pf
	mov word ptr cs:[Plusscucc1],BONUS
pf:
	cmp word ptr cs:[Plusscucc2],BONUS
	jl pff
	mov word ptr cs:[Plusscucc2],BONUS
pff:
	cmp word ptr cs:[Minuscucc1],BONUS
	jl pfff
	mov word ptr cs:[Minuscucc1],BONUS
pfff:
	cmp word ptr cs:[Minuscucc2],BONUS
	jl pffff
	mov word ptr cs:[Minuscucc2],BONUS
pffff:

	add cx,word ptr cs:[PlussCucc1]
	sub cx,word ptr cs:[MinusCucc1]
	add dx,word ptr cs:[PlussCucc2]
	sub dx,word ptr cs:[MinusCucc2]
				;itt t�r�nk ki vele!

	IRET
Normal:
	call Old33h		;h�vjuk az eredetit
	IRET			;�s kil�p�nk!

Proc Old33h
	pushf
	db 9ah	;FARCALL
Oldint:	dw 0, 0
	RET
Endp

Counter:	dw	0	;minden ennyiedik h�v�skor sz�molok
Sensitivity:	dw	2	;�rz�kenys�g is dinamikusan v�ltozik!
Cuccmok:	dw	0
Plusscucc1:	dw	0
Plusscucc2:	dw	0
Minuscucc1:	dw	0
MinusCucc2:	dw	0
SizeOfInt equ $ - Int33h	;Interruptrezidens Rutin m�rete!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	     -=F�programr�sz=-		;;;
Foprogram:
	push cs
	pop ds			;ds �ll�t�s

	mov ax,3533h
	int 21h			;R�gi c�m lek�rdez�se
	mov word ptr [Oldint],bx
	mov word ptr [Oldint+2],es

	mov ax,2533h
	mov dx,offset Int33h
	int 21h			;�j int rutin regisztr�ci�

	mov ax,3100h
	mov dx,(SizeOfInt+0ffeh)/16+100	;rezidens m�ret+kis r�hagy�s!
	int 21h				;Rezidens programexit!!!

Program Ends
  END start

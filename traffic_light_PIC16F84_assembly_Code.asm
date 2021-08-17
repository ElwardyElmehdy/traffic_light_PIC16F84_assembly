

list p=16f84a
#include <p16f84a.inc>
        __CONFIG  _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
    
    ;declaration de variable
    cblock 0x0c 
      compteur
      d1 
      d2
      d3
	endc
	
;demarage sur le reset
	ORG 0x000
	goto init
	
;initialisation
	
init 
	bsf STATUS,RP0
	clrf TRISB
    clrf TRISA
	bcf STATUS,RP0
    clrf PORTB
   
  goto main
   



init_compteur 
    movlw 0x00
	movwf compteur
    goto affichage_7segment
;programme principale

main
call sequence_1
call sequence_2
call sequence_3
call sequence_4
call sequence_5
call sequence_6
goto main

;sous programme
affichage_7segment ;sous programme pour décomptage de deux afficheurs
call segment
movwf PORTB
call delay_1s
incf compteur
movlw 0x15
xorwf compteur,W ;pour tester est ce que compteur=21 
btfsc STATUS,Z ;si oui en return si non en sauter la ligne(Z=1 donc compteur=21)
return
goto affichage_7segment




sequence_1
bsf PORTA,RA4 ;éteindre les deux afficheur 7 segment
bsf PORTA,RA0  ;allumer R1
bsf PORTA,RA3  ;1ere clignotements de V2
call delay_500ms
bcf PORTA,RA3
call delay_500ms
bsf PORTA,RA3    ;2eme clignotements de V2
call delay_500ms
bcf PORTA,RA3
call delay_500ms
bsf PORTA,RA3   ;3eme clignotements de V2
call delay_500ms
bcf PORTA,RA3
call delay_500ms
bsf PORTA,RA3   ;4eme clignotements de V2
call delay_500ms
bcf PORTA,RA3
return


sequence_2
bsf PORTA,RA4 ;éteindre les deux afficheur 7 segment
bsf PORTA,RA0  ;allumer R1
bsf PORTB,RB7  ;allumer J2 pendant 2 second
call delay_1s
call delay_1s
bcf PORTA,RA0
bcf PORTB,RB7
return

sequence_3
bcf PORTA,RA4 ;alumer les deux afficheurs 7 segment
bsf PORTA,RA1 ;allumer V1
bsf PORTA,RA2  ;allumer R2
call init_compteur
bcf PORTA,RA1 
bcf PORTA,RA2
return

sequence_4
bsf PORTA,RA4 ;éteindre les deux afficheurs 7 segment
bsf PORTA,RA2  ;allumer R2
bsf PORTA,RA1  ;1ere clignotements de V1
call delay_500ms
bcf PORTA,RA1
call delay_500ms
bsf PORTA,RA1    ;2eme clignotements de V1
call delay_500ms
bcf PORTA,RA1
call delay_500ms
bsf PORTA,RA1   ;3eme clignotements de V1
call delay_500ms
bcf PORTA,RA1
call delay_500ms
bsf PORTA,RA1   ;4eme clignotements de V1
call delay_500ms
bcf PORTA,RA2
bcf PORTA,RA1
return

sequence_5
bsf PORTA,RA4 ;éteindre les deux afficheurs 7 segment
bsf PORTA,RA2  ;allumer R2
bsf PORTB,RB6  ;allumer J2 pendant 2 second
call delay_1s
call delay_1s
bcf PORTA,RA2  
bcf PORTB,RB6
return

sequence_6
bcf PORTA,RA4 ;alumer les deux afficheurs 7 segment
bsf PORTA,RA3 ;allumer V2
bsf PORTA,RA0 ;allumer R1
call init_compteur
bcf PORTA,RA3 
bcf PORTA,RA0
return

segment ;creation de tableau pour l'utulisation dans le decomptage
	movf compteur,W
	addwf PCL,F
	retlw 0x20
	retlw 0x19
	retlw 0x18
	retlw 0x17
	retlw 0x16
	retlw 0x15
	retlw 0x14
	retlw 0x13
	retlw 0x12
	retlw 0x11
    retlw 0x10
	retlw 0x09
	retlw 0x08
	retlw 0x07
	retlw 0x06
	retlw 0x05
	retlw 0x04
	retlw 0x03
	retlw 0x02
	retlw 0x01
    retlw 0x00





;temporisation de 500 ms(0.5s)
delay_500ms
movlw D'205'
movwf d3
movlw D'5'
movwf d2
movlw D'161'
movwf d1
decfsz d1
goto $-1 ;sauter vers la ligne président
decfsz d2
goto $-5 ;sauter vers le 5e président ligne
decfsz d3
goto $-9;sauter vers le 9e président ligne
return
		
	

;temporisation de 1 second
delay_1s
movlw D'46'
movwf d3
movlw D'189'
movwf d2
movlw D'37'
movwf d1
decfsz d1
goto $-1
decfsz d2
goto $-5
decfsz d3
goto $-9
return

	
end
; 10 SYS (2304)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


*=$0900

EYE_FRONT=#$2E80 / 64
EYE_LEFT=#$2E40 / 64
EYE_RIGHT=#$2E00 / 64

PROGRAM_START

        JSR INITIALIZE_EYE_SPRITE

        JSR SETUP_CUSTOM_INTERRUPT_HANDLER
        
        

PROGRAM_END
        rts

COUNTER BYTE 00

SETUP_CUSTOM_INTERRUPT_HANDLER
        SEI
        LDA #<ANIMATION_ROUTINE
        STA $0314
        LDA #>ANIMATION_ROUTINE
        STA $0315
        CLI
        RTS

ANIMATION_ROUTINE
        LDX COUNTER
        INX
        STX COUNTER
        JMP $EA31


INITIALIZE_EYE_SPRITE
        ; Loads all sprite data
        JSR LOAD_EYE_FRONT_DATA
        JSR LOAD_EYE_LEFT_DATA
        JSR LOAD_EYE_RIGHT_DATA

        ; Sets the sprite pointer to the eye front frame
        LDA EYE_FRONT
        STA $07F8

        ; sets sprite 0's color to white
        LDA #1
        STA $D027

        ; enables sprite 0
        LDA #1
        STA $D015

        ; sets sprite 0's location
        LDA #$40
        STA $D000
        LDA #1
        STA $D010
        LDA #50
        STA $D001
        RTS


LOAD_EYE_FRONT_DATA
        LDX #64
        LDY #00 
copy_eye_front_data_loop
        LDA EYE_FRONT_DATA,Y
        STA $2E80,Y
        INY
        DEX
        BNE copy_eye_front_data_loop
        RTS

LOAD_EYE_LEFT_DATA
        LDX #64
        LDY #00 
copy_eye_left_data_loop
        LDA EYE_LEFT_DATA,Y
        STA $2E40,Y
        INY
        DEX
        BNE copy_eye_left_data_loop
        RTS

LOAD_EYE_RIGHT_DATA
        LDX #64
        LDY #00 
copy_eye_right_data_loop
        LDA EYE_RIGHT_DATA,Y
        STA $2E00,Y
        INY
        DEX
        BNE copy_eye_right_data_loop
        RTS


EYE_FRONT_DATA
; eye_front
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$81,$FA
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $5F,$81,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_LEFT_DATA
; eye_left
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5C,$7F,$FA
 BYTE $58,$3F,$FA
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $58,$3F,$FA
 BYTE $5C,$7F,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_RIGHT_DATA
; eye right
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$FE,$3A
 BYTE $5F,$FC,$1A
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $5F,$FC,$1A
 BYTE $5F,$FE,$3A
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00


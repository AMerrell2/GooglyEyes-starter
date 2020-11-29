; 10 SYS (2304)
watch COUNTER

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


*=$0900

EYE_FRONT=#$2E80 / 64
EYE_LEFT=#$2E40 / 64
EYE_RIGHT=#$2E00 / 64

PROGRAM_START


        ; Initializes the eye sprite
        JSR INITIALIZE_EYE_SPRITE

        ; Sets up the cusom interrupt handler
        JSR SETUP_CUSTOM_INTERRUPT_HANDLER
        
        

PROGRAM_END
        rts

COUNTER BYTE 00

; Sets the interrupt handler to the address for the custom handler
; Inputs:
; A: The low byte of the ANIMATION_ROUTINE address
; A: The high byte of the ANIMATION_ROUTINE address
; Outputs:
; 0314: The low byte of the ANIMATION_ROUTINE address
; 0315: The high byte of the ANIMATION_ROUTINE address
SETUP_CUSTOM_INTERRUPT_HANDLER
        SEI
        LDA #<ANIMATION_ROUTINE
        STA $0314
        LDA #>ANIMATION_ROUTINE
        STA $0315
        CLI
        RTS

; Adds to the counter and calls the subroutine to switch frames
; Inputs:
; A: COUNTER
; Outputs:
; COUNTER: COUNTER + 1
ANIMATION_ROUTINE
        LDA COUNTER
        ADC #1
        STA COUNTER
        CMP #0
        BEQ SHOW_EYE_FRONT
        CMP #64
        BEQ SHOW_EYE_LEFT
        CMP #128
        BEQ SHOW_EYE_FRONT
        CMP #192
        BEQ SHOW_EYE_RIGHT
        JMP $EA31

; Points to the eye front pixel data
; Inputs:
; A: #$BA The one byte address for the pixel data
; Outputs:
; $07F8: The one byte address for the pixel data
SHOW_EYE_FRONT
        LDA EYE_FRONT
        STA $07F8
        JMP $EA31

; Points to the eye left pixel data
; Inputs:
; A: #$B9 The one byte address for the pixel data
; Outputs:
; $07F8: The one byte address for the pixel data
SHOW_EYE_LEFT
        LDA EYE_LEFT
        STA $07F8
        JMP $EA31

; Points to the eye right pixel data
; Inputs:
; A: #$B8 The one byte address for the pixel data
; Outputs:
; $07F8: The one byte address for the pixel data
SHOW_EYE_RIGHT
        LDA EYE_RIGHT
        STA $07F8
        JMP $EA31

; Initializes the eye sprite
; Inputs: None
; Outputs: None
INITIALIZE_EYE_SPRITE
        ; Loads all sprite data
        JSR LOAD_EYE_FRONT_DATA
        JSR LOAD_EYE_LEFT_DATA
        JSR LOAD_EYE_RIGHT_DATA

        ; Sets the sprite pointer to the eye front frame
        JSR SET_INITIAL_SPRITE_FRAME

        ; sets sprite 0's color to white
        JSR SET_SPRITE_COLOR

        ; enables sprite 0
        JSR SET_SPRITE_VISIBILITY

        ; sets sprite 0's location
        JSR SET_SPRITE_LOCATION
        RTS

; Sets the sprite to the eye front frame
; Inputs:
; A: #$BA
; Outputs:
; $07F8: #$BA
SET_INITIAL_SPRITE_FRAME
        LDA EYE_FRONT
        STA $07F8
        RTS

; Sets the sprite to white
; Inputs:
; A: #1
; Outputs:
; $D027: #1
SET_SPRITE_COLOR
        LDA #1
        STA $D027
        RTS

; Sets the visibility of the sprite to on
; Inputs:
; A: #1
; Outputs:
; $D015: #1
SET_SPRITE_VISIBILITY
        LDA #1
        STA $D015
        RTS

; Sets the sprite location
; Inputs:
; A: #$40 the first part of the x location
; A: #1 the second part of the x location
; A: #50 the y location
; Outputs:
; $D000: The first part of the x location
; $D010: The second part of the x location
; $D001: The y location
SET_SPRITE_LOCATION
        LDA #$40
        STA $D000
        LDA #1
        STA $D010
        LDA #50
        STA $D001
        RTS

; Loads the eye front pixel data
; Inputs:
; A: each byte from the eye front byte data
; Outputs:
; 2E80 - 2EBF: each byte of the eye front byte data. One byte per address
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

; Loads the eye left pixel data
; Inputs:
; A: each byte from the eye left byte data
; Outputs:
; 2E40 - 2E7F: each byte of the eye left byte data. One byte per address
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

; Loads the eye right pixel data
; Inputs:
; A: each byte from the eye right byte data
; Outputs:
; 2E00 - 2E3F: each byte of the eye right byte data. One byte per address
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


%org($07, bank7_free_space)

run_timer:
; increment frame count by 1, rollover at 60
    inc !timer_frames_current
    lda !timer_frames_current : cmp #60 : bcc .done
    lda #$00 : sta !timer_frames_current

    inc !timer_seconds_current
    lda !timer_seconds_current : cmp #99 : bcc .done
    lda #$00 : sta !timer_seconds_current



    ; seconds count is 100, stop updating the timer
    lda #99 : sta !timer_seconds_current
    lda #59 : sta !timer_frames_current

.done

;print the timer

    ldx !ppu_buffer_cursor
    lda #$00 : sta !ppu_buffer, x : inx                                                 ; starting byte, this probably specifies the format of the pput data
    lda #!TIMER_current_time_ppu_address_low : sta !ppu_buffer, x : inx                      ; destination address low
    lda #!TIMER_current_time_ppu_address_high : sta !ppu_buffer, x : inx                     ; destination address high
    lda #$05 : sta !ppu_buffer, x : inx                                                 ; data length
    ldy !timer_seconds_current : lda hex_to_dec_tens, y : sta !ppu_buffer, x : inx      ; data
    lda hex_to_dec_units, y : sta !ppu_buffer, x : inx
    lda #$0b : sta !ppu_buffer, x : inx
    ldy !timer_frames_current : lda hex_to_dec_tens, y : sta !ppu_buffer, x : inx 
    lda hex_to_dec_units, y : sta !ppu_buffer, x : inx

    stx !ppu_buffer_cursor



    ; restore hijacked instruction
    jsr $e196

    rts

hex_to_dec_tens:
		db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01 ; 0
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; 10
        db $03,$03,$03,$03,$03,$03,$03,$03,$03,$03 ; 20
        db $04,$04,$04,$04,$04,$04,$04,$04,$04,$04 ; 30
        db $05,$05,$05,$05,$05,$05,$05,$05,$05,$05 ; 40
        db $06,$06,$06,$06,$06,$06,$06,$06,$06,$06 ; 50
        db $07,$07,$07,$07,$07,$07,$07,$07,$07,$07 ; 60
        db $08,$08,$08,$08,$08,$08,$08,$08,$08,$08 ; 70
        db $09,$09,$09,$09,$09,$09,$09,$09,$09,$09 ; 80
        db $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a ; 90

hex_to_dec_units:
		db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 0
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 10
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 20
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 30
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 40
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 50
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 60
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 70
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 80
        db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0a ; 90

on_new_level:
    jsr timer_new_room

    ; restore hijacked instruction
    jsr $c179

    rts 

on_new_stage:
    jsr timer_new_room

    ; restore hijacked instruction
    jsr $c179

    rts 

on_new_screen:
    jsr timer_new_room

    ; restore hijacked instruction
    jsr $c179

    rts 

on_decrement_lives:
    jsr timer_new_room

    ; not restoring hijacked instruction since it's the one that decrements lives and i want to skip it

    ; clear overflow flag to force a branch
    clv 

    rts 

after_hud_draw:
    jsr print_previous_room_time

    ; restore hijacked instruction
    jsr $b8f7

    rts 


timer_new_room:
    lda !timer_seconds_current : sta !timer_seconds_previous
    lda !timer_frames_current : sta !timer_frames_previous
    lda #$00 : sta !timer_seconds_current : sta !timer_frames_current

    ; print previous room time
print_previous_room_time:    
    ldx !ppu_buffer_cursor
    lda #$00 : sta !ppu_buffer, x : inx                                                 ; starting byte, this probably specifies the format of the pput data
    lda #!TIMER_previous_time_ppu_address_low : sta !ppu_buffer, x : inx                ; destination address low
    lda #!TIMER_previous_time_ppu_address_high : sta !ppu_buffer, x : inx               ; destination address high
    lda #$05 : sta !ppu_buffer, x : inx                                                 ; data length
    ldy !timer_seconds_previous : lda hex_to_dec_tens, y : sta !ppu_buffer, x : inx     ; data
    lda hex_to_dec_units, y : sta !ppu_buffer, x : inx
    lda #$0b : sta !ppu_buffer, x : inx
    ldy !timer_frames_previous : lda hex_to_dec_tens, y : sta !ppu_buffer, x : inx 
    lda hex_to_dec_units, y : sta !ppu_buffer, x : inx


    stx !ppu_buffer_cursor

    rts 


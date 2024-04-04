@include

macro org(bank, offset)
    org $10+(<offset>%$4000)+($4000*<bank>)
    base <offset>
endmacro

; new ram
!timer_seconds_current              = $7a0
!timer_frames_current               = $7a1
!timer_seconds_previous             = $7a2
!timer_frames_previous              = $7a3


; existing ram
!ppu_buffer                         = $200
!ppu_buffer_cursor                  = $41a


; rom
bank0_every_frame_hijack            = $8091
bank0_print_score                   = $b7fb
bank7_free_space                    = $eb00
bank6_hud_zeros                     = $81c8
bank7_after_hud_draw_hijack         = $d2c3
bank0_on_new_level_hijack           = $20d1
bank0_on_new_stage_hijack           = $210e
bank0_on_new_screen_hijack          = $1ea8
bank0_decrement_lives_hijack        = $8c7b


; constants
!INPUT_right                              = $01
!INPUT_left                               = $02
!INPUT_down                               = $04
!INPUT_up                                 = $08
!INPUT_start                              = $10
!INPUT_select                             = $20
!INPUT_B                                  = $40
!INPUT_A                                  = $80
!TIMER_current_time_ppu_address_low       = $5b
!TIMER_current_time_ppu_address_high      = $20
!TIMER_previous_time_ppu_address_low      = $54
!TIMER_previous_time_ppu_address_high     = $20
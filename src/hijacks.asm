@include

; should run every frame in gameplay after NMI
%org($00, bank0_every_frame_hijack)
        jsr run_timer

%org($00, bank0_on_new_level_hijack)
        jsr on_new_level

%org($00, bank0_on_new_stage_hijack)
        jsr on_new_stage

%org($00, bank0_on_new_screen_hijack)
        jsr on_new_screen

%org($00, bank0_decrement_lives_hijack)
        jsr on_decrement_lives
        bvc $06

%org($07, bank7_after_hud_draw_hijack)
        jsr after_hud_draw
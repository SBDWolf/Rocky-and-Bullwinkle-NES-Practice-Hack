norom

incsrc "defines.asm"
incsrc "hijacks.asm"
incsrc "edits.asm"

%org($01, bank7_free_space)
incsrc "timer.asm"
warnpc $10000
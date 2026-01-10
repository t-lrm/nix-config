#!/bin/sh

alpha='dd'
background='#282a36'
selection='#44475a'
comment='#6272a4'

yellow='#f1fa8c'
orange='#ffb86c'
red='#ff5555'
magenta='#ff79c6'
blue='#6272a4'
cyan='#8be9fd'
green='50fa7b'
white='ffffff'

transparent=00000000
shadow_col="000000b3"
shadow_w="2"

i3lock-color \
  --ignore-empty-password \
  --show-failed-attempts \
  --keylayout 2 \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$transparent \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$white$alpha \
  --line-uses-ring \
  --keyhl-color=$green$alpha \
  --bshl-color=$red$alpha \
  --separator-color=$selection$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --modif-color=$red \
  --layout-color=$blue \
  --date-color=$white\
  --time-color=$white\
  --layout-color=$white \
  --blur 1 \
  --clock \
  --time-str="%H:%M:%S" \
  --date-str="%A %e %B %Y" \
  --verif-text="Checking..." \
  --wrong-text="Wrong pswd" \
  --noinput="No Input" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --radius=120\
  --ring-width=2 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys \
  --time-size=32 \
  --date-size=18 \
  --layout-size=10 \
  --time-font="JetBrains Mono" \
  --date-font="JetBrains Mono" \
  --layout-font="JetBrains Mono" \
  --verif-font="JetBrains Mono" \
  --wrong-font="JetBrains Mono" \
  --nofork \

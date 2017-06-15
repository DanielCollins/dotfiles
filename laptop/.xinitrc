#!/bin/sh

setenv LANG en_US.UTF-8

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

xrdb -merge /etc/X11/xinit.Xresources
xrdb -merge ~/.Xresources
xmodmap /etc/X11/xinit/.Xmodmap

xsetroot -cursor_name left_ptr &
xautolock -time 10 -locker "./lock.sh" -detectsleep -notify 2 &

xmonad

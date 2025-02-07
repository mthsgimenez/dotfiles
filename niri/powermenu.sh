#!/bin/bash

case "$(echo -e " Desligar\n Reiniciar\n Suspender\n󰩈 Sair" | fuzzel -d --index -f "RobotoMono Nerd Font:size=18" -l 4 -w 13)" in
        "0") exec systemctl shutdown;;
        "1") exec systemctl reboot;;
        "2") exec systemctl suspend;;
        "3") exec niri msg action quit -s;;
esac

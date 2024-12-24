#! /usr/bin/env bash

function brt() {
    if [[ ! -z $2 ]]; then
        brt-one "$1" "$2"
        return 0
    fi
    if [[ -z $1 ]]; then
        printf "Usage:\nbrt-all brightness[0-100]\n"
        ddcutil --display 1 getvcp 10
        return 1
    fi
    local brightness=${1:-50}
    local monitors=$(ddcutil detect | grep -Po "Display \d" | wc -l)
    for i in $(seq 1 "$monitors"); do
        echo "ddcutil --display $i setvcp 10 $brightness"
        echo "Current brightness:"
        ddcutil --display "$i" setvcp 10 "$brightness" >/dev/null
    done
}

function brt-one() {
    local monitor=$1
    local brightness=$2
    if [[ -z "$2" ]] || [[ -z "$1" ]]; then
        printf "Usage:\nbrt monitor[1-9] brightness[0-100]\n"
        printf "monitors: \n$(ddcutil detect | grep -Po "Display \d")\n"
        printf "Current brightness:\n"
        ddcutil --display "${1:-1}" getvcp 10
        return 1
    fi
    echo "ddcutil --display $monitor setvcp 10 $brightness"
    ddcutil --display "$monitor" setvcp 10 "$brightness"
}

function contrast() {
    if [[ -z $1 ]]; then
        printf "Usage:\n$0 contrast[0-100]\n"
        ddcutil --display 1 getvcp 12
        return 1
    fi
    local contrast=${1:-50}
    local monitors=$(ddcutil detect | grep -Po "Display \d" | wc -l)

    for i in $(seq 1 "$monitors"); do
        echo "ddcutil --display $i setvcp 12 $contrast"
        echo "Current Contrast: "
        ddcutil --display "$i" setvcp 12 "$contrast"
    done
}

function monitor-input-switch() {
    local monitor=$1
    local source=$2
    local vcp_code="60"
    if [[ -z $1 ]]; then
        printf "Usage: \n$0 monitor[0-9] source['HDMI', 'DP']\n"
        return 1
    fi
    case $source in
    "HDMI" | "hdmi" | "hd")
        source="0x11"
        ;;
    "DP" | "dp")
        source="0x0f"
        ;;
    "off")
        vcp_code="D6"
        source="4"
        ;;
    "on")
        vcp_code="D6"
        source="1"
        ;;
    *)
        source="0x0f"
        ;;
    esac
    ddcutil --display "$monitor" setvcp "$vcp_code" "$source"
}

# monitor control

alias monitor-work="monitor-input-switch 1 hdmi; monitor-input-switch 2 hdmi"
alias monitor-left-work="monitor-input-switch 1 hd; monitor-input-switch 2 dp"
alias monitor-home="monitor-input-switch 1 dp; monitor-input-switch 2 dp"

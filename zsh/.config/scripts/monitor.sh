#! /usr/bin/env bash

function brt() {
    # if two args passed in, then call brt-one. Yes very confusing but convenient :/
    if [[ -n $2 ]]; then
        brt-one "$1" "$2"
        return 0
    fi
    if [[ -z $1 ]]; then
        printf "Usage:\nbrt-all brightness[0-100]\n"
        ddcutil --display 1 getvcp 10
        return 1
    fi
    local -r brightness=${1:-50}
    local -r monitors=$(ddcutil detect | grep -Po "Display \d" | wc -l)
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
    local -r contrast=${1:-50}
    local -r monitors=$(ddcutil detect | grep -Po "Display \d" | wc -l)

    for i in $(seq 1 "$monitors"); do
        echo "ddcutil --display $i setvcp 12 $contrast"
        echo "Current Contrast: "
        ddcutil --display "$i" setvcp 12 "$contrast"
    done
}

function monitor-input-switch() {
    local -r monitor=$1
    local source=$2
    local vcp_code="60" # see `ddcutil capabilities`
    # Feature: 60 (Input Source)
    #    Values:
    #       01: VGA-1
    #       0f: DisplayPort-1
    #       11: HDMI-1

    if [[ -z $1 ]]; then
        echo "Usage: 
    $0 monitor[0-9] source['HDMI', 'DP']"
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
        echo "Usage: 
    $0 monitor[0-9] source['HDMI', 'DP']"
        source="0x0f"
        return 1
        ;;
    esac
    ddcutil --display "$monitor" setvcp "$vcp_code" "$source"
    return 0
}

# monitor control

alias monitor-work="monitor-input-switch 1 hdmi && monitor-input-switch 2 hdmi"
alias monitor-half="monitor-input-switch 1 dp && monitor-input-switch 2 hdmi"
alias monitor-home="monitor-input-switch 1 dp && monitor-input-switch 2 dp"

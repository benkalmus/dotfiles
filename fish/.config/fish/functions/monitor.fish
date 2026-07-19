function brt
    if test (count $argv) -eq 2
        brt-one $argv[1] $argv[2]
        return 0
    end
    if test -z "$argv[1]"
        echo "Usage: brt brightness[0-100]"
        ddcutil --display 1 getvcp 10
        return 1
    end
    set brightness $argv[1]
    set monitors (ddcutil detect | grep -Po "Display \d" | wc -l)
    for i in (seq 1 $monitors)
        echo "ddcutil --display $i setvcp 10 $brightness"
        ddcutil --display $i setvcp 10 $brightness >/dev/null
    end
end

function brt-one
    if test -z "$argv[2]" -o -z "$argv[1]"
        echo "Usage: brt-one monitor[1-9] brightness[0-100]"
        echo "monitors: "(ddcutil detect | grep -Po "Display \d")
        ddcutil --display "$argv[1]" getvcp 10 2>/dev/null
        return 1
    end
    echo "ddcutil --display $argv[1] setvcp 10 $argv[2]"
    ddcutil --display $argv[1] setvcp 10 $argv[2]
end

function contrast
    if test -z "$argv[1]"
        echo "Usage: contrast contrast[0-100]"
        ddcutil --display 1 getvcp 12
        return 1
    end
    set contrast_val $argv[1]
    set monitors (ddcutil detect | grep -Po "Display \d" | wc -l)
    for i in (seq 1 $monitors)
        echo "ddcutil --display $i setvcp 12 $contrast_val"
        ddcutil --display $i setvcp 12 $contrast_val
    end
end

function monitor-input-switch
    if test -z "$argv[1]"
        echo "Usage: monitor-input-switch monitor[0-9] source[HDMI, DP, off, on]"
        return 1
    end

    set monitor $argv[1]
    set source $argv[2]
    set vcp_code "60"

    switch $source
        case HDMI hdmi hd
            set source "0x11"
        case DP dp
            set source "0x0f"
        case off
            set vcp_code "D6"
            set source "4"
        case on
            set vcp_code "D6"
            set source "1"
        case '*'
            echo "Usage: monitor-input-switch monitor[0-9] source[HDMI, DP, off, on]"
            return 1
    end
    ddcutil --display "$monitor" setvcp "$vcp_code" "$source"
end
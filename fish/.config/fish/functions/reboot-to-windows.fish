function reboot-to-windows
    set boot_number (efibootmgr | grep "Windows" | head -n 1 | sed -En 's/Boot([0-9]+).*/\1/p')
    if test -z "$boot_number"
        echo "Windows boot number not found in command 'efibootmgr'"
        return 1
    end
    sudo efibootmgr -n "$boot_number"
    echo "Boot '$boot_number' set. Run 'sudo reboot' to start to Windows"
    echo "Reboot to windows now? [yY]"
    read -l response
    if string match -q -r '[yY]' "$response"
        echo "Rebooting now"
        sleep 3
        sudo reboot
    end
end
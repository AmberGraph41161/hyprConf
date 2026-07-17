#!/bin/zsh
notificationlifetime=1000
notificationid=100000000

acpiInformation=$(acpi -b)
MaxCapacity=$(echo MaxCapacity: $(cat /sys/class/power_supply/BAT0/capacity 2> /dev/null))
CapacityLevel=$(echo CapacityLevel: $(cat /sys/class/power_supply/BAT0/capacity_level 2> /dev/null))
Cycles=$(echo Cycles: $(cat /sys/class/power_supply/BAT0/cycle_count 2> /dev/null))
AC=$(echo AC: $(cat /sys/class/power_supply/AC/online 2> /dev/null))
Status=$(echo Status: $(cat /sys/class/power_supply/BAT0/status 2> /dev/null))
ChargeStartThreshold=$(echo ChargeStartThreshold: $(cat /sys/class/power_supply/BAT0/charge_start_threshold 2> /dev/null))

batteryinfomation="$acpiInformation\n"
batteryinfomation+="$MaxCapacity\n"
batteryinfomation+="$CapacityLevel\n"
batteryinfomation+="$Cycles\n"
batteryinfomation+="$AC\n"
batteryinfomation+="$Status\n"
batteryinfomation+="$ChargeStartThreshold"

notify-send "Battery Info" "$batteryinfomation" -t $notificationlifetime -r $notificationid -h "int:value:$(cat /sys/class/power_supply/BAT0/capacity)"

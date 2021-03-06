#!/bin/bash
#exec 2>/dev/null

if [ ! $1 ]; then
  echo ""
  echo "--- EXAMPLE ---"
  echo "./overclock_vega.sh 1 2 3 4 5 6"
  echo "1 = GPUID"
  echo "2 = Memory Clock"
  echo "3 = Core Clock"
  echo "4 = Fan Speed"
  echo "5 = VDDC"
  echo "6 = MVDD"
  echo ""
  echo "-- Full Example --"
  echo "./overclock_navi.sh 0 875 1900 80 900 skip"
  echo ""
fi

if [ $1 ]; then

 #################################£
  # Declare
  GPUID=$1
  MEMCLOCK=$2
  CORECLOCK=$3
  FANSPEED=$4
  VDDC=$5
  MVDD=$6

  echo "--**--**-- GPU $1 : VEGA 56/64 --**--**--"

  # Requirements
  sudo su -c "echo 1 > /sys/class/drm/card$GPUID/device/hwmon/hwmon?/pwm1_enable"
  sudo su -c "echo manual > /sys/class/drm/card$GPUID/device/power_dpm_force_performance_level"
  sudo su -c "echo 4 > /sys/class/drm/card$GPUID/device/pp_power_profile_mode" # Compute Mode


  # VDDC, MEMCLOCK, CORECLOCK
  echo
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  echo "Navi is not supported by Clocktune yet"
  echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  echo

  # Apply
  #sudo ./rocm-smi --setsclk 7
  #sudo ./rocm-smi --setmclk 3
  sudo su -c "echo '1' > /sys/class/drm/card$GPUID/device/pp_dpm_sclk"
  sudo su -c "echo '3' > /sys/class/drm/card$GPUID/device/pp_dpm_mclk"
  # Check current states
  sudo su -c "cat /sys/class/drm/card$GPUID/device/pp_od_clk_voltage"
  #sudo cat /sys/kernel/debug/dri/0/amdgpu_pm_info

  # ECHO Changes
  echo "-÷-*-****** CORE CLOCK *****-*-*÷-"
  sudo su -c "cat /sys/class/drm/card$GPUID/device/pp_dpm_sclk"
  echo "-÷-*-****** MEM  CLOCKS *****-*-*÷-"
  sudo su -c "cat /sys/class/drm/card$GPUID/device/pp_dpm_mclk"
  sudo su -c "echo '1' > /sys/class/drm/card$GPUID/device/pp_dpm_sclk"
  sudo su -c "echo '3' > /sys/class/drm/card$GPUID/device/pp_dpm_mclk"

  exit 1



fi

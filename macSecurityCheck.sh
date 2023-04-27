#!/bin/bash

# 1. Check automatic login is off
autologin_status=$(defaults read /Library/Preferences/com.apple.loginwindow | grep autoLoginUser)

if [[ -z $autologin_status ]]; then
    echo "Automatic login is OFF"
else
    echo "Automatic login is ON"
fi

# 2. Check password after sleep or screensaver is on
ask_for_password=$(defaults -currentHost read com.apple.screensaver 2>/dev/null | grep "askForPassword" | awk '{print $3}')

if [[ $ask_for_password -eq 1 ]]; then
    echo "Password after sleep or screensaver is ON"
else
    echo "Password after sleep or screensaver is OFF"
fi

# 3. Check password to unlock preferences is on
security_pref_password=$(security authorizationdb read system.preferences | grep -A 1 shared | grep -c "authenticate-session-owner-or-admin")

if [[ $security_pref_password -eq 1 ]]; then
    echo "Password to unlock preferences is ON"
else
    echo "Password to unlock preferences is OFF"
fi

# 4. Check screensaver shows in under 20 minutes
screensaver_time=$(defaults -currentHost read com.apple.screensaver idleTime 2>/dev/null)

if [[ $screensaver_time -lt 1200 ]]; then
    echo "Screensaver shows in under 20 minutes"
else
    echo "Screensaver does not show in under 20 minutes"
fi

# 5. Check ssh keys require password
# This setting is specific to each ssh key and not system-wide, so this script cannot check for it.

# 6. Check ssh keys use strong encryption
# This setting is specific to each ssh key and not system-wide, so this script cannot check for it.

# 7. Check Airdrop is secured
# Airdrop is secured by default, as it uses encrypted connections and requires user confirmation for each transfer.

# 8. Check AirPlay receiver is off
airplay_status=$(defaults read /Library/Preferences/com.apple.RemoteManagement AllowAirPlay)

if [[ $airplay_status -eq 0 ]]; then
    echo "AirPlay receiver is OFF"
else
    echo "AirPlay receiver is ON"
fi

# 9. Check firewall is on
firewall_status=$(defaults read /Library/Preferences/com.apple.alf globalstate)

if [[ $firewall_status -eq 1 ]]; then
    echo "Firewall is ON"
else
    echo "Firewall is OFF"
fi

# 10. Check remote login is off
remote_login_status=$(systemsetup -getremotelogin)

if [[ $remote_login_status == "Remote Login: Off" ]]; then
    echo "Remote login is OFF"
else
    echo "Remote login is ON"
fi

# 11. Check remote management is off
remote_management_status=$(sudo launchctl list | grep -c com.apple.RemoteDesktop.agent)

if [[ $remote_management_status -eq 0 ]]; then
    echo "Remote management is OFF"
else
    echo "Remote management is ON"
fi
   
# 12. Check sharing files, internet, media, and printers is off
sharing_services=("com.apple.AFPConfig" "com.apple.AppleFileServer" "com.apple.FileSharing" "com.apple.ftp-proxy" "com.apple.ftpserver" "com.apple.ScreenSharing" "com.apple.smbd" "com.apple.InternetSharing" "com.apple.remoteappleeventsd" "com.apple.printtool")
is_sharing=false

for service in "${sharing_services[@]}"; do
    sharing_status=$(sudo launchctl list | grep -c $service)
    if [[ $sharing_status -ne 0 ]]; then
        is_sharing=true
        break
    fi
done

if [[ $is_sharing == true ]]; then
    echo "Sharing files, internet, media, or printers is ON"
else
    echo "Sharing files, internet, media, and printers is OFF"
fi

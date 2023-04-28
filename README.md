# Mac Security Settings Check Script

This script checks various security settings on your macOS system and reports their status. The script verifies the following settings:

1. Automatic login is off
2. Password after sleep or screensaver is on
3. Password to unlock preferences is on
4. Screensaver shows in under 20 minutes
5. AirPlay receiver is off
6. Firewall is on
7. File sharing is off
8. Internet sharing is off
9. Media sharing is off
10. Printer sharing is off
11. Remote login is off
12. Remote management is off

## Prerequisites

- macOS system
- Administrator privileges

## Usage

1. Save the script as `mac_security_check.sh`.
2. Open Terminal.
3. Navigate to the folder containing the script.
4. Run the following command to give the script execute permissions:

```chmod +x mac_security_check.sh```

5. Execute the script with administrator privileges:

```sudo ./mac_security_check.sh```


The script will display the status of the various security settings on your system.

## Disclaimer

This script is provided "as is" and is for informational purposes only. The author and publisher are not responsible for any errors or omissions, or for the consequences of using the information provided herein. Use at your own risk.


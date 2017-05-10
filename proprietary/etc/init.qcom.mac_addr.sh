#!/system/bin/sh
# get_macaddrs (Cyanogen 7)
# by subpsyke
#
# This script will read the MAC addresses from Samsung's RIL.

unset WIFIMAC
unset BTMAC

# Skip processing if MAC addresses are already written
if [ -f /data/.mac.info -a -f /data/.bt.info ]; then
	echo "MAC addresses already found."
fi

# Wait until Samsung's RIL announces MAC addresses
until [ $(expr length "$WIFIMAC") == 17 ]; do
	WIFIMAC=`getprop ril.wifi_macaddr`
	sleep 1
done

until [ $(expr length "$BTMAC") == 12 ]; do
	BTMAC=`getprop ril.bt_macaddr`
	sleep 1
done

# Set WiFi MAC address
echo $WIFIMAC >/data/.mac.info

# Convert BT MAC address to proper format
echo $BTMAC | sed 's!^M$!!;s!\-!!g;s!\.!!g;s!\(..\)!\1:!g;s!:$!!' >/data/.bt.info

exit

#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 6088704 eeb67331d1b98ff22eec3f76865dccb1263e8edb 3872768 6c55e0c4805717ed0d23660132477713ed593151
fi

if ! applypatch -c EMMC:/dev/block/mmcblk0p13:6088704:eeb67331d1b98ff22eec3f76865dccb1263e8edb; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/mmcblk0p8:3872768:6c55e0c4805717ed0d23660132477713ed593151 EMMC:/dev/block/mmcblk0p13 eeb67331d1b98ff22eec3f76865dccb1263e8edb 6088704 6c55e0c4805717ed0d23660132477713ed593151:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi

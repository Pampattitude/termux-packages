#!/data/data/com.termux/files/usr/bin/bash
RESTART_INSTRUCTIONS="Dropping to shell. To rebuild, swipe from the top of your screen, touch the arrow on the right side of your Termux Notificiation, touch "Exit", then relaunch this app."
if ! ls /storage/emulated/0 >/dev/null 2>&1
then
    yes | pkg install termux-am
	yes | termux-setup-storage	
fi
cat <<EOF
___  _  _ _ _    ___  ____ ____
|__] |  | | |    |  \ |___ |__/
|__] |__| | |___ |__/ |___ |  \\
EOF


yes | termux-wake-lock
    [ -f /storage/emulated/0/Download/baserom.us.z64 ] &&	rm -f ~/baserom.us.z64
    [ -f /storage/emulated/0/Download/baserom.eu.z64 ] &&	rm -f ~/baserom.eu.z64
    [ -f /storage/emulated/0/Download/baserom.jp.z64 ] &&	rm -f ~/baserom.jp.z64

    [ -f /storage/emulated/0/Download/baserom.us.z64 ] &&	cp /storage/emulated/0/Download/baserom.us.z64 ~/
    [ -f /storage/emulated/0/baserom.us.z64 ] &&					cp /storage/emulated/0/baserom.us.z64 ~/
    [ -f /storage/emulated/0/Download/baserom.eu.z64 ] && cp /storage/emulated/0/Download/baserom.eu.z64 ~/
    [ -f /storage/emulated/0/baserom.eu.z64 ] &&					cp /storage/emulated/0/baserom.eu.z64 ~/
    [ -f /storage/emulated/0/Download/baserom.jp.z64 ] && cp /storage/emulated/0/Download/baserom.jp.z64 ~/
    [ -f /storage/emulated/0/baserom.jp.z64 ] &&					cp /storage/emulated/0/baserom.jp.z64 ~/
if [[ -f ~/baserom.us.z64 || -f ~/baserom.eu.z64 || -f ~/baserom.jp.z64 ]]
then
	echo

	if [ -f ~/baserom.us.z64 ]
	then
		BASEROM_PATH=~/baserom.us.z64
		echo "Found rom $(basename "${BASEROM_PATH}")"
	elif [ -f ~/baserom.eu.z64 ]
	then
		BASEROM_PATH=~/baserom.eu.z64
		echo "Found rom $(basename "${BASEROM_PATH}")"
	elif [ -f ~/baserom.jp.z64 ]
	then
		BASEROM_PATH=~/baserom.jp.z64
		echo "Found rom $(basename "${BASEROM_PATH}")"
	fi
else
	echo 'Autodetecting baserom.*.z64. This can take a long time.'
	BASEROM_PATH=$(find /storage/emulated/0 -type f -exec md5sum {} + 2>/dev/null | grep '^20b854b239203baf6c961b850a4a51a2' | head -n1 | cut -d'/' -f2- | xargs -I "%" echo /%)
fi
BASEROM_FILE=$(basename "${BASEROM_PATH}")

# https://stackoverflow.com/questions/34457830/press-any-key-to-abort-in-5-seconds
if read -r -s -n 1 -t 5 -p "Press any key within 5 seconds to cancel build" key #key in a sense has no use at all
then
	echo && echo $RESTART_INSTRUCTIONS
	exit 0
fi

BLOCKS_FREE=$(awk -F ' ' '{print $4}' <(df | grep emulated))
if (( 2097152 > BLOCKS_FREE ))
then
	cat <<EOF
____ _  _ _    _   
|___ |  | |    |   
|    |__| |___ |___
EOF
    echo 'Your device storage needs at least 2 GB free space to continue!'
	echo $RESTART_INSTRUCTIONS
	exit 1
fi
if [ -z "${BASEROM_PATH}" ]
then
	cat <<EOF
_  _ ____    ____ ____ _  _
|\ | |  |    |__/ |  | |\/|
| \| |__|    |  \ |__| |  |
EOF
    echo "Go to https://github.com/sanni/cartreader to learn how to get ${BASEROM_FILE}"
	echo $RESTART_INSTRUCTIONS
	exit 2
else
	cp "${BASEROM_PATH}" "~/${BASEROM_FILE}"
fi
apt-mark hold bash
yes | pkg upgrade -y
yes | pkg install git wget mesa-dev make python getconf zip apksigner clang binutils libglvnd-dev aapt which netcat-openbsd
cd
if [ -d "sm64ex-omm" ]
then
	cp "${BASEROM_PATH}" "sm64ex-omm/${BASEROM_FILE}"
	cd sm64ex-omm
	git reset --hard HEAD
	git pull origin izzys
	git submodule update --init --recursive
	make distclean
else
	git clone --recursive https://github.com/izzy2fancy/sm64ex-omm.git
	cp "${BASEROM_PATH}" "sm64ex-omm/${BASEROM_FILE}"
	cd sm64ex-omm
fi
VERSION="$(echo ${BASEROM_FILE} | cut -d. -f2)" make 2>&1 | tee build.log
if ! [ -f build/us_pc/sm64.us.f3dex2e.apk ]
then
	cat <<EOF
____ ____ _ _    _  _ ____ ____
|___ |__| | |    |  | |__/ |___
|    |  | | |___ |__| |  \ |___
EOF
    cat build.log | nc termbin.com 9999
	echo $RESTART_INSTRUCTIONS
	exit 3
fi
cp build/us_pc/sm64.us.f3dex2e.apk /storage/emulated/0
cat <<EOF
___  ____ _  _ ____
|  \ |  | |\ | |___
|__/ |__| | \| |___
EOF
echo 'Go to Files and touch sm64.us.f3dex2e.apk to install!'
yes | termux-wake-unlock
echo $RESTART_INSTRUCTIONS

#!/sbin/sh

set -e
exec &> /tmp/ubuntu-sd-partitioner.log

echo "Creating data and cache partitions on SD card.."

while [ ! -e "/dev/block/mmcblk1" ]; do
	echo "Waiting for SD card to show up.."
	sleep 1
done

echo "Checking existing partitions.."
parted -s /dev/block/mmcblk1 print
part2info=$(parted -s /dev/block/mmcblk1 print | grep " 2 " || true )


if [[ "$part2info" != "" ]]; then
	echo "It seems like your SD card has more than one partition already. Not changing anything."
else
	echo "Getting disk info..."
	diskinfo=$(parted -s /dev/block/mmcblk1 unit B print | grep "Disk /dev/block/mmcblk1" | sed 's%.*: ([0-9]+)B$$%\\1%')
	set -- $diskinfo
	diskSize=$(echo $3 | sed 's/B$//')
	echo "Disk size: $diskSize bytes"

	echo "Getting partition info.."
	partinfo=$(parted -s /dev/block/mmcblk1 unit B print | grep " 1 " || true)
	echo "Partition info: $partinfo"
	set -- $partinfo

	start=$(echo $2 | sed 's/B$//')
	end=$(echo $3 | sed 's/B$//')
	newEnd=$(expr $diskSize - 4294967297 || true)
	diff=$(expr $end - $newEnd || true)
	
	echo "Start: $start End: $end New End: $newEnd. Diff: $diff"
	if [ "$diff" -ne "0" ]; then
		echo "Resizing now!"
		parted -s /dev/block/mmcblk1 unit b resize 1 $start $newEnd
		echo "Partition resized!"
	fi
	
	dataStart=$(expr $newEnd + 1)
	dataEnd=$(expr $dataStart + 3221225471)
	echo "Creating data partiton: start $dataStart end $dataEnd"
	parted -s /dev/block/mmcblk1 unit b mkpart primary ext2 $dataStart $dataEnd
	echo "Partition created!"
	while [ ! -e "/dev/block/mmcblk1p2" ]; do
		sleep 1
	done
	mke2fs -t ext4 /dev/block/mmcblk1p2
	
	cacheStart=$(expr $dataEnd + 1)
	cacheEnd=$(expr $cacheStart + 1073741823)
	echo "Creating cache partiton: start $cacheStart end $cacheEnd"
	parted -s /dev/block/mmcblk1 unit b mkpart primary ext2 $cacheStart $cacheEnd
	echo "Partition created!"
	while [ ! -e "/dev/block/mmcblk1p3" ]; do
		sleep 1
	done
	mke2fs -t ext4 /dev/block/mmcblk1p3
fi

mount /dev/block/mmcblk1p2 /data || true

touch /tmp/ubuntu-partitions-created

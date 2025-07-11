architecture=$(uname -a)
#architecture=$(uname -a | awk '{print $12 " " $3}')
#architecture1=$(uname -m)
#architecture2=$(uname -r)

cpu=$(cat /proc/cpuinfo | grep 'physical id' | wc -l)
vcpu=$(cat /proc/cpuinfo | grep 'processor' | wc -l)

memusage=$(free -h --total | grep Mem | awk '{print $3}')
memtotal=$(free -h --total | grep Mem | awk '{print $2}')
mempercent=$(free -k --total | grep Mem | awk '{printf("%.2f%%"),$3/$2*100}')

diskusage=$(df -h --total | grep total | awk '{print $3}')
disktotal=$(df -h --total | grep total | awk '{print $2}')
diskpercent=$(df -h --total | grep total | awk '{print $5}')

cpuload=$(top -b -n 1 | grep '%Cpu' | awk '{printf("%.2f%%"), $2 + $4}')

lastboot=$(who -b | awk '{print $3 " " $4}')

lvm=$(if (lsblk | grep lvm | wc -l -eq 0);
then
	echo "active"
else
	echo "inactive"
fi)

tcp=$(cat /proc/net/sockstat | grep TCP | awk '{print $3}')
userlog=$(who | wc -l)

hostname=$(hostname -I)
network=$(ip link | grep ether | awk '{print $2}')
sudo=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)


wall "
#Architecture : $architecture
#CPU physical : $cpu
#vCPU : $vcpu
#Memory Usage : $memusage MB / $memtotal MB ($mempercent)
#Disk Usage : $diskusage / $disktotal ($diskpercent)
#CPU Load : $cpuload
#Last boot : $lastboot
#LVM use : $lvm
#Connections TCP : $tcp
#User log : $userlog
#Network :$hostname ($network)
#Sudo : $sudo
"

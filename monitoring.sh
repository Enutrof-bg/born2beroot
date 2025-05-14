architecture=$(uname -a)

cpu=$()
vcpu=$()

memusage=$(free -m --total | grep Total | awk '{print $3}')
memtotal=$(free -m --total | grep Total | awk '{print $2}')
mempercent=$(free -k --total | grep Mem | awk '{printf("%.2f%%"),$3/$2*100}')

diskusage=$(df -h --total | grep total | awk '{print $3}')
disktotal=$(df -h --total | grep total | awk '{print $2}')
diskpercent=$(df -h --total | grep total | awk '{print $5}')

cpuload=$()

lastboot=$(who -b | awk '{print $3 " " $4}')

lvm=$()
tcp=$(cat /proc/net/sockstat | grep TCP | awk '{print $3}')
userlog=$(who | wc -l)

hostname=$(hostname -I)
network=$(ip link | grep ether | awk '{print $2}')
sudo=$(cat /var/log/sudo/sudo_config | grep COMMAND | wc -l)


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






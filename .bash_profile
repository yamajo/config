clear
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 7)
    _____.___.                    __________.__
    \__  |   |____    _____ _____ \______   \__|
     /   |   \__  \  /     \\__   \ |     ___/  |
     \____   |/ __ \|  Y Y  \/ __ \|    |   |  |
     / ______(____  /__|_|  (____  /____|   |__|
     \/           \/      \/     \/

$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %T"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Adresses IP........: `/sbin/ifconfig eth0 | /bin/grep "inet adr" | /usr/bin/cut -d ":" -f 2 | /usr/bin/cut -d " " -f 1` / `curl -s http://myexternalip.com/raw`
( : '~'.~.'~' : ) Charge moyenne.....: ${one} (1m), ${five} (5min), ${fifteen} (15min)
 ~ .~ (   ) ~. ~  Processus en exec..: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   Memoire (RAM)......: `free -m | awk 'NR==2 { printf "Total: %sMB, Utilisé: %sMB, Libre: %sMB",$2,$3,$4; }'`
   '~ .~~~. ~'    Espace Stockage....: Total: `df -Pkh | grep -E '^/dev/root' | awk '{ print $2 }'`, Utilisé: `df -Pkh | grep -E '^/dev/root' | awk '{ print $3 }'` (`df -Pk | grep -E '^/dev/root' | awk '{ print $5 }'`), Libre: `df -Pkh | grep -E '^/dev/root' | awk '{ print $4 }'`$(tput setaf 1)
       '~'
$(tput sgr0)"

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

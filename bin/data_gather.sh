#! /bin/sh

#credits

DATELOG=`date -R`

#Get cpu temps - requires lm_sensors
echo $(sensors -u | awk '/Core /{c=2}c&&c--' | tr "\n" "\t" | sed 's/temp._input//g' | sed 's/Core /\^cpuid\=/g' | sed 's/\: /\,\ temperature=/g' |  sed 's/\://g' |  sed 's/    //g' | sed 's/\^/\r\n'"$DATELOG"' /g')


#Get Proxmox Version

ProxmoxVersion=$(uname -a) 

echo $DATELOG ProxmoxVersion="'$ProxmoxVersion'"

#Get systemload

echo $DATELOG $(uptime | awk '{ print "SystemLoad1min="$10"\n""SystemLoad5min="$11"\n""SystemLoad10min="$12}"\n"')

# Get ZPOOL info

for i in $(zpool list | awk 'NR>1' | awk '{print $1}')
do
        PoolName=`zpool list $i | awk 'NR>1' | awk '{print $1}'`
        Size=`zpool list $i  | awk 'NR>1' | awk '{print $2}'`
        Allocated=`zpool list $i  | awk 'NR>1' | awk '{print $3}'`
        Free=`zpool list $i  | awk 'NR>1' | awk '{print $4}'`
        EXPANDSZ=`zpool list $i  | awk 'NR>1' | awk '{print $5}'`
        FRAG=`zpool list $i | awk 'NR>1' | awk '{print $6}'`
        CAP=`zpool list $i  | awk 'NR>1' | awk '{print $7}'`
        DEDUP=`zpool list $i  | awk 'NR>1' | awk '{print $8}'`
        HEALTH=`zpool list $i  | awk 'NR>1' | awk '{print $9}'`
        ALTROOT=`zpool list $i  | awk 'NR>1' | awk '{print $10}'`
        echo $DATELOG PoolName=$PoolName, Size=$Size, Allocated=$Allocated, Free=$Free, EXPANDSZ=$EXPANDSZ, FRAG=$FRAG, CAP=$CAP, DEDUP=$DEDUP, HEALTH=$HEALTH, ALTROOT=$ALTROUT 
done




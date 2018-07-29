#Get Drive info

DATELOG=`date -R`

for i in $(ls /dev/sd[a-z])
do
        DevModelFamily=`smartctl -a $i | awk '/Model Family:/{print $0}' | awk '{ print substr($0, index($0,$3)) }'`
        DevName=`smartctl -a $i | awk '/Device Model:/{print $0}' | awk '{ print substr($0, index($0,$3)) }'`
        DevSerNum=`smartctl -a $i | awk '/Serial Number:/{print $0}' | awk '{ print substr($0, index($0,$3)) }'`
        DevLU_WWN_Device_Id=`smartctl -a $i | awk '/LU WWN Device Id:/{print $0}' | awk '{ print substr($0, index($0,$5)) }'`
        DevFirmware_Version=`smartctl -a $i | awk '/Firmware Version:/{print $0}' | awk '{ print substr($0, index($0,$3)) }'`
        DevUser_Capacity=`smartctl -a $i | awk '/User Capacity:/{print $0}' | awk '{ print substr($0, index($0,$3)) }' | sed 's/\,//g'`
        DevSector_Size=`smartctl -a $i | awk '/Sector Size:/{print $0}' | awk '{ print substr($0, index($0,$3)) }' | sed 's/\,//g' | sed 's/\ /_/g'`
        Dev_is=`smartctl -a $i | awk '/Device is:/{print $0}' | awk '{ print substr($0, index($0,$3)) }' | sed 's/\,//g' | sed 's/\ /_/g'`
        DevSATA_Version=`smartctl -a $i | awk '/SATA Version is:/{print $0}' | awk '{ print substr($0, index($0,$5)) }' | sed 's/\,//g' | sed 's/\ /_/g'`
        DevATA_Version=`smartctl -a $i | awk '/^ATA Version is:/{print $0}' | awk '{ print substr($0, index($0,$4)) }'| sed 's/\,//g' | sed 's/\ /_/g'`
        DevLocal_Time=`smartctl -a $i | awk '/Local Time is:/{print $0}' | awk '{ print substr($0, index($0,$4)) }'`
        DevSMART_support=`smartctl -a $i | awk '/SMART support is:/{print $0}' | awk '{ print substr($0, index($0,$4)) }' | sed 's/\,//g' | sed 's/\ /_/g'`
        DevATA_Version=`smartctl -a $i | awk '/ATA Version is:/{print $0}' | awk '{ print substr($0, index($0,$4)) }' | sed 's/\,//g' | sed 's/\ /_/g'`
        DevTemp=`smartctl -a $i | awk '/Temperature_Celsius/{print $0}' | awk '{print $10}'`

        echo $DATELOG dev=$i, temperature=$DevTemp, DriveSerialNumber=$DevSerNum, DriveBrand=$DevName, DriveModel=$DevModelFamily, DevLU_WWN_Device_Id=$DevLU_W$
done


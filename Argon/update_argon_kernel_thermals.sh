#!/bin/sh
#!/system/bin/sh

#update_argon_kernel_thermals.sh puts new/different thermal control files 
#in place for the Argon kernel.
# 
#This file should be placed in /system/etc/init.d or otherwise started 
#at boot-up time.  It can also be run at any time to replace/update the 
#thermal control files

#######################################################################
#USER OPTIONS                                                         #
#######################################################################

######Choose the thermal setting

selected_custom_setting="medium-kernel-thermal"

#Thermal settings possible choices:

#Low1 is similar to Argon kernel orig, maxfreq 1958Mhz. Low2 is same but maxfreq is a notch higher.
#And so on until Low6, which has maxfreq 2880Mhz (highest available on OPO)
#selected_custom_setting="low1-kernel-thermal" 
#selected_custom_setting="low2-kernel-thermal" 
#selected_custom_setting="low3-kernel-thermal" 
#selected_custom_setting="low4-kernel-thermal" 
#selected_custom_setting="low5-kernel-thermal" 
#selected_custom_setting="low6-kernel-thermal" 

#selected_custom_setting="medium-low-kernel-thermal" #Slight boost above Argon original

#selected_custom_setting="medium-kernel-thermal" #About the same as factory stock Oneplus One

#selected_custom_setting="medium-high1-kernel-thermal" #Somewhat into overclocking territory vs factory stock
#selected_custom_setting="medium-high2-kernel-thermal" #Even more into overclocking territory

#selected_custom_setting="orig-kernel-thermal" #Argon kernel 16.1 original

#Note that two sets of thermal settings are included in directories marked (DO NOT USE-CRASHES IMMEDIATELY!)
#They will in fact crash your device immediately if put under high CPU load. They are included
#only for purposes of experimentation and investigation of the cause of the crashes.



#######Set the directories

#The directory where you unzipped the replacement thermal settings files
#You may have to adjust this based on your exact system setup 
#or where you unzipped the files
#Make sure to end with /
customthermalsettings_dir="/storage/emulated/0/Argon/" 

#you shouldn't have to change this unless Argon Kernel changes somehow
argonmsm_dir="/sys/kernel/msm_thermal" 



#if not running as root, restarts the script as root
#(root needed to replace kernel/system files)
#[ `whoami` = root ] || exec su -c $0 root ls /root

 

cp -TRv "$customthermalsettings_dir$selected_custom_setting" "$argonmsm_dir"

cp_result=$?

if [ $cp_result -ne 0 ]
then
    result="ERROR: Unsuccessful in updating thermals for Argon Kernel to $selected_custom_setting. No thermal settings changed."
else
    result="Successfully updated thermals for Argon Kernel to $selected_custom_setting"        
fi

#Write result to stdout - you can see this if you are running the script from shell
echo $result

#Result to logcat--can view using a logcat utility or looking at the file directly
log -p v -t "update_argon_kernel_thermals.sh" "$result"

#the following command uses the small app Notify4Scripts to send an Android notification that the script was executed. To see the notifications, install Notify4Scripts.apk file from:

#https://github.com/halnovemila/Notify4Scripts 

#Notify4Scripts app is optional--if it's missing you simply won't receive the Android notification when the thermal settings are initialized or there is an error

am startservice -e int_id 2 -e str_title "Argon Kernel Thermals Set" -e str_content "$result" -e b_execdebug 1 -n com.hal9k.notify4scripts/.NotifyServiceCV


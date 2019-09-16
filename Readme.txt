These files are for tuning the thermal protection parameters of the Argon Kernel for the Oneplus One.  

You can set then up to auto run on startup. 

WARNING!!!!! 
Changing the thermal cutoff values can damage and even ruin your CPU and phone permanently!  These settings have NOT been extensively tested, especially not in extreme or unusual systems or under very high and long-lasting loads, and could easily damage your phone under those conditions or any others.  Watch device temperatures and shut down if a dangerous temperature is reached.  
WARNING!!!!!  

----------------
What's New - ver 1.1
----------------

 - Much faster refresh rate on all options.  
 - All settings tested using a CPU stress tester.  See cup-stress-test-results.txt
 - 12 available settings files instead of 3, ranging from cool/low performance to higher performance/hotter
 - Discovered that values in the zoneX files do not really correspond to degrees celsius as reported by most CPU temperature tools.  So not really sure exactly how the files work or what other factors besides msm_thermal might be in play in setting CPU frequencies.


----------------
HOW TO SET UP AUTO START/INSTALL PREFERRED THERMAL SETTINGS ON BOOT
---------------- 

The file update_argon_kernel_thermals.sh - which is included in this zip file - will run as a shell script and auto-install the thermal settings you want, either at boot or whenever you run it. 

 - UNZIP all files in the .zip to /sdcard/Argon

 - Edit update_argon_kernel_thermals.sh to use the settings files you want (see section SETTINGS FILES INCLUDED that explains the options) and to make sure the directories are correct for your system. 

 - Now you need to auto-run update_argon_kernel_thermals.sh at bootup time:
 
   o The Argon kernel does not seem to have/use init.d, so you can't use that. 

   o Several apps at F-Droid or the Play Store will run scripts at system boot. Search for "init.d".  Just install that app, then choose   Argon/update_argon_kernel_thermals.sh as the file to run at boot-up
   
   o If you're using Kernel Adiutor already, it includes a capability to run a script at boot (menu/Init.d in Kernel Adiutor)

I use init.d script support by Ryo Software. I simply set it to run .sh scripts in the /Argon directory on boot, with a 1 minute delay. 

https://play.google.com/store/apps/details?id=com.ryosoftware.initd

-----------------
HOW TO MANUALLY/TEMPORARILY TRY OUT NEW THERMAL SETTINGS
-----------------
Read the section below, HOW IT WORKS - FROM THE ARGON DEVELOPER.

Open this directory: /sys/kernel/msm_thermal

Backup the current thermal settings (all files in that directory) to a safe place. 

To implement a new thermal throttling regimen, you can just copy the files in one of the directories in this zip to replace all the existing files in your /sys/kernel/msm_thermal directory.     
 
You'll need a root file explorer app. So, for example, I use X-Plorer (from the Play Store) to copy all the files in directory /sdcard/Argon/medium-overclock-kernel-thermal to /sys/kernel/msm_thermal 
 
The changes take effect as soon as you paste the files in place and will last until you re-boot. 

-----------------------
SETTINGS FILES INCLUDED
-----------------------
 
Included in this .zip are six directories, each with a set of thermal files to allow you to experiment with different thermal settings.
 
----
 IMPORTANT change for ver 1.1: All thermal settings sample at a rate of 250ms.  That is w-a-y down from the original sampling rate of 8000ms (8 seconds).  Based on actual experience, the Oneplus One cpus can go from 45 degrees to overheating in way less than 8 seconds, especially if you're allowing 2880Mhz clock rates.  The change to 250ms sample rates should give a lot more thermal protection than before--even when using the overclocked medium thermal settings--yet have minimal or no effect on the device otherwise.
 
 Most device crashes are probably due to overheating and overheating can lead to failure of electronics over time.  So stopping overheats before they start is important for stopping crashes as well as keeping devices generally healthy. The 250ms sample rate should help a lot with that
 
 The stock Argon 16.1 thermal settings don't seem to overheat simply because the max CPU setting is low enough that even with the 8000ms sampling rate, the CPU is unlikely to get hot enough to cause problems. The 1958Mhz max frequency would overheat in a while--but it would take longer than 8 seconds.
----
 
 Below are the thermal settings options available, in order from least to most aggressive.
 
 Generally, the lower-end thermals will give slower but more steady performance and will keep CPU temps a bit lower.
 
 Towards the higher end, the instantaneous performance will be a fair bit higher compared with low-end settings (15%?).  This performance will decline over a period (a couple of minutes) of extended high CPU usage, though the final performance will still be somewhat higher than the lower-end settings.  Temperatures will be a several degrees higher under steady-state high CPU use.
 
 For gaming (ie, long-term steady moderate to high CPU use) you might prefer a steadier lower-end setting.  For more occasional or normal use, you might prefer a higher-end setting that will give you that higher burst of speed for a few seconds.
 
 Based on stress-testing, the very highest settings are just a few tweaks away from overheating/crashing the device. So if you use one of those settings and find that the devices crashes under extended high CPU load (say, an app that gets stuck and keeps the device hot for 20 minutes or an hour) that would be a good reason to move a notch or two lower down the scale.
 
 **** lowX-boost-kernel-thermal: Similar to the original files as found in ver 16.1 of the Argon kernel. Sampling @ 250ms.  The only difference between low1, low2, ..., low6 is the user_maxfreq value:
 
    low1 = 1958K (same as Argon 16.1 stock thermals)
	.. (gradually increase the maxfreq value in steps
	low6 = 2880K (max possible with this CPU)
 
 **** medium-low-kernel-thermal: A moderate increase to the original files. Overall max possible freq is 2458Mhz. Sampling @ 250ms.
 
 **** medium-kernel-thermal: A moderate increase again. Overall max possible freq is 2573Mhz. Sampling @ 250ms.  This is probably similar to the factory stock OPO settings?  The max frequency out-of-box was 2573Mhz, anyway.
 
 
 **** medium-high1-thermal: Yet another moderate increase. Overall max possible freq is 2726Mhz.  The frequencies below that are pushed up in temperature a bit, so that it runs just a bit hotter and keeps slightly higher frequencies than medium. Sampling @ 250ms.  
 
 **** medium-high2-thermal: Same as medium-high1-thermal except that max frequency is 2880Mhz (max attainable of the OPO).
 
 **** orig-kernel-thermal: The original thermal settings included with the Argon kernel v. 16.1.  I actually **do not** recommend using these files at this time, because they include the *very* lengthy 8000ms sampling rate. It still may be OK, because the max cpu frequency is so low.  But I would recommend the low-boost-kernel-thermal as settings very similar to the original--in fact even more conservative at temperatures over 75 degrees--and also including the 250ms sample rate. 
 
 **** high-thermalX(DO NOT USE-CRASHES IMMEDIATELY!): As it says on the tin: These will crash your device immediately if it is put under full CPU load.  I am not sure the reason--it seems to happen too quickly to be thermal-related.  I am including these files in case anyone wants to experiment and determine why they crash so quickly.
 
 A summary of stress test results for each set of thermal settings is in cpu-stress-test-results.txt
 
 A list of available frequencies for the Krait 400 and other helpful information is in cpu freqs.txt
 
 The CPU frequencies can be found on your device at:
 
 /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
 /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies
 etc.
 
 Those directories also have other helpful information about your CPUs.
  
  
----------------
ABOUT THE ARGON KERNEL AND HOW THE THERMAL REGULATION FILES WORK IN ARGON - FROM ARGON DEVELOPER TOMOMS
----------------

More about the Argon Kernel here:

https://forum.xda-developers.com/oneplus-one/development/kernel-argon-kernel-t3833348

The files included in this .zip are based on Tomoms' comments on the discussion thread here: https://forum.xda-developers.com/showpost.php?p=79237804&postcount=238

In a forum post, Tomoms wrote:

The thermal driver's parameters are tunable. Not in the most straightforward of ways, but you can do it. 

Open this directory: /sys/kernel/msm_thermal. 

There you'll find some files where you can set the temperature threshold above which the CPU frequency must be capped at a given frequency (because it's heating up too much), and the threshold below which the CPU is allowed to run at a higher frequency (because it's starting to cool down). 

The syntax of those files is:

[frequency] [throttling temperature] [un-throttling temperature]

Also in that directory:

 - The file "user_maxfreq" includes a value that defines the max frequency allowed for the CPU. 
 - File "sampling_ms" sets the sampling rate in milliseconds
 - File "enabled" enables or disables the thermal settings (1= enable, 0=disable)
 
 (Perhaps?) VERY IMPORTANT DETAIL!  All files must end with a return (newline).  When you open the files, it looks like they have two lines--one with the numbers and a second blank line.  If that extra blank line is not in the file then the kernel code won't read the file properly.
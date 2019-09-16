These files are for tuning the thermal protection parameters of the Argon Kernel for the Oneplus One.  

WARNING!!!!! 
Changing the thermal cutoff values can damage and even ruin your CPU and phone permanently!  These settings have NOT been extensively tested, especially not in extreme or unusual systems or under very high and long-lasting loads, and could easily damage your phone under those conditions or any others.  Watch device temperatures and shut down if a dangerous temperature is reached.  
WARNING!!!!!   

More about the Argon Kernel here:

https://forum.xda-developers.com/oneplus-one/development/kernel-argon-kernel-t3833348

The files included in this .zip are based on Tomoms' comments on the discussion thread here: https://forum.xda-developers.com/showpost.php?p=79237804&postcount=238

Tomoms' Argon Kernal Github repository: https://github.com/Tomoms/argon_kernel

---------

The thermal driver's parameters are tunable. Not in the most straightforward of ways, but you can do it. 

Open this directory: /sys/kernel/msm_thermal. 

There you'll find some files where you can set the temperature threshold above which the CPU frequency must be capped at a given frequency (because it's heating up too much), and the threshold below which the CPU is allowed to run at a higher frequency (because it's starting to cool down). 

The syntax of those files is:

[frequency] [throttling temperature] [un-throttling temperature]

---------

Also the file user_maxfreq includes a value that defines the max frequency allowed for the CPU.
 
 Included in this .zip are three directories, each with a set of thermal files to allow you to experiment with different thermal settings.
 
 So, to implement a new thermal throttling regimen, you can just copy the files in one of the directories in this zip to replace the existing files in your /sys/kernel/msm_thermal directory.  
 
 Make a backup copy of your original files first!  
 
 Use a root file explorer program to copy/paste the files from your sdcard to this directory (X-plore, for example).
 
 The changes take effect as soon as you paste the files in place and will last until you re-boot.  If you want to implement that changes permanently, you could write a small script to copy the new files in place on system startup.
 
 The directories/options available are:
 
 *** orig-kernel-thermal: Original files as found in ver 16.1 of the Argon kernel.  They start throttling the CPU at 43 degree, the max frequency is 1728Mhz. Frequencies decrease from there as the temperatures rise.  Overall max possible frequency (even at very low temps) is 1958Mhz.
 
 *** moderate-boost-kernel-thermal: A moderate increase to the original files. Throttling starts at 53 degrees and the frequency there is 2265Mhz.  Generally adds 10 degrees and a couple of notches of frequency to the original at each stage.  Above 85 degrees freq is shut down to 422Mhz, which should (?) cool things quickly if you get to that point. Overall max possible freq is 2458Mhz. 
 
 *** large-boost-kernel-thermal: A pretty large boost to the temperatures allowed, starting by allowing frequencies up to 2880Mhz through 72 degrees, then gradually throttling the frequencies back from there to 85 degrees.  Above 85 it is throttled to 268Mhz, so hopefully enough to cool things down quickly. Overall max possible freq is 2880Mhz.
 
 
 
 A list of available frequencies for the Krait 400 and other helpful information is in cpu freqs.txt
 
 The CPU frequencies can be found on your device at:
 
 /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
 /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies
 etc.
 
 Those directories also have other helpful information about your CPUs.
  

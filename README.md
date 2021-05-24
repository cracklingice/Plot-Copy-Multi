Moves Chia plots from the directory the batch file is started in to the configured destinations.  Chia Plot Copy Multi will move to the first specified directory with sufficient free space.

Chia Plot Copy Multi should be considered beta at this time because I do not have a large amount of hardware to test it with.  There is definitely going to be a maximum size for the final directory due to the 32-bit integer limit, but I'm not certain how large of a pool of free space would be required to break it, I believe it would be 21TiB.  It would also break if you somehow managed to have less than 10,000 bytes of free space.  There's also the small potential that the plot could be larger than the available space by 10,000 and that would break it too.  I believe these issues would not be likely to occour, but feel that I should mention the possibility.

To use Chia Plot Copy:

Save plotcopymulti.bat to the final folder you are plotting into. This could be the same SSD you are using for temp or a separate staging SSD.

Right click the batch file and select edit. On the 8th line down you will specify the destinations you want to copy your plots to. An example configuration is provided on the lines above it. Take note that spaces in the directory path are not supported.

Launch Chia Plot Copy. Chia Plot Copy will now check the directory it is started from once per minute for a completed plot file and if found it will rename the plot file to a temporary file, move the file to the configured destination and remove .tmp from the end so that the harvester can pick it up. The renaming is done to prevent the harvester from picking up on the plot while the copy is incomplete.

See also: https://github.com/cracklingice/Chia-Plot-Instance-Launcher

XCH: xch1aaryeda5ayqw56ue7zluavhj5dryda4pqzv0s9lnyandw4u0chxs6w74p9

DOGE: DD9nxzaaidMw4tQpZEvTNGCQ3NDdhpXYJJ

RVN: RHTVCcDpPvVawqgxPqxMEVUwBszR1AEMmX

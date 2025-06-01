The Gensyn node creates very large temporary files. If you have little space on your VPS, you risk a system crash.
These two setup scripts, initialized as cron jobs, monitor the disk capacity and Gensyn temporary files every 6 hours, while deleting model files used for the calculation that are older than two days.
Another setup script intervenes in case of emergency by unloading the memory from the temporary files, checking the disk capacity every hour.

Once you have copied yourself to the /home folder, run the setup:
```
bash ~/cleanup_rl_swarm.sh
bash ~/emergency_cleanup.sh
```
Check the configured cron jobs
```
crontab -l
```
Manually test the scripts to be sure
```
~/cleanup_rl_swarm.sh
~/emergency_cleanup.sh
```
You should get something like this:
```
0 */6 * * * /home/[USER]/cleanup_rl_swarm.sh >> /home/xrdpuser/cleanup.log 2>&1
0 * * * * /home/[USER]/emergency_cleanup.sh >> /home/xrdpuser/emergency.log 2>&1
```
If not, call the cron jobs directly, one line at a time (replace [USER], with your user):

line 1:
```
(crontab -l 2>/dev/null; echo "0 */6 * * * /home/[USER]/cleanup_rl_swarm.sh >> /home/[USER]/cleanup.log 2>&1") | crontab -
```
Line 2
```
(crontab -l 2>/dev/null; echo "0 * * * * /home/[USER]r/emergency_cleanup.sh >> /home/[USER]/emergency.log 2>&1") | crontab -
```
Verify that everything is running well:
```
crontab -l
```

#! /bin/bash
#               #Write a shell script (with comments, and identations) to:
#               #1-Monitor every 1 min the system load
#               #2-Add the load , and date to a log file /var/log/systemLoad


#############  Define log file path ######
LOG_PATH='/var/log/systemload'


########### Current Date ################
DATE=$(date)

########### Monitor Load  ################
LOAD=$(uptime | awk -F 'load average:' '{ print $2 }' )

########### Print the result ################
#echo "$DATE ------- Load: $LOAD" >> $LOG_PATH

logger -t "taskBah" "the time = $DATE , the load is : $LOAD"

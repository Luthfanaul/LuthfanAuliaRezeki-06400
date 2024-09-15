Process = "nginx"

LOG_FILE="/var/log/process_monitor.log"

if ! pgrep -x "$PROCESS" > /dev/null; then
	sudo systemctl start $PROCESS

	echo "$(date): $PROCESS was not running and has been started." >> else 
	echo $(date): $PROCESS is running." >> $LOG_FILE
fi

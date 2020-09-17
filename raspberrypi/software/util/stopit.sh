sudo killall worker.php
sudo killall watchdog.sh
sudo rm /run/worker.pid
sudo systemctl restart php7.3-fpm
sudo systemctl restart nginx
sudo systemctl stop mpd


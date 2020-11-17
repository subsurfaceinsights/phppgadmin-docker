#!/bin/sh
set -e

docker_config_file=/var/lib/nginx/html/conf/docker.config.inc.php
if [ -z "$PHP_PG_ADMIN_SERVER_HOSTS" ]
then
  echo "Notice: 'PHP_PG_ADMIN_SERVER_HOSTS' env var is not set";
  echo "If you do not provide a custom config file, the software will not be"
  echo "usable."
fi 
echo "<?php" > $docker_config_file
serv_num=0
for server in $(echo $PHP_PG_ADMIN_SERVER_HOSTS | sed "s/,/ /g")
do 
  cat << EOF >> $docker_config_file
\$conf['servers'][$serv_num]['desc'] = '$server'; 
\$conf['servers'][$serv_num]['host'] = '$server'; 
\$conf['servers'][$serv_num]['port'] = 5432;
\$conf['servers'][$serv_num]['sslmode'] = 'allow';
\$conf['servers'][$serv_num]['defaultdb'] = 'template1';
EOF
  serv_num=$((serv_num+1))
done
echo  "?>" >> $docker_config_file


exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf





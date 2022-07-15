#!/bin/bash
set -uex


test -d /etc/supervisord.d/user-custom/ || sudo mkdir -p /etc/supervisord.d/user-custom/


if test ! -f /etc/supervisord.conf
then
{
   echo_supervisord_conf > /tmp/supervisord.conf
cat  >> /tmp/supervisord.conf <<EOF
[include]
files = /etc/supervisord.d/user-custom/*.conf
EOF

sudo mv /tmp/supervisord.conf /etc/supervisord.conf

}
fi

num=$(ps -ef | grep  'supervisord' | grep -v 'grep' | wc -l)
if test $num -eq 0
then
{
  supervisord -c /etc/supervisord.conf
}
else
{
  echo 'supervisor ready running !'
}
fi

supervisorctl status
supervisorctl update
supervisorctl status
tail -f /dev/null
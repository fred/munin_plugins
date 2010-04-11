#!/bin/bash

EMAIL="root"
MESSAGE="/tmp/message.txt"

TIME_WAIT_LIMIT=20
STABLISHED_LIMIT=200

TIME_WAIT=`netstat -n | grep TIME_WAIT | wc -l | sed 's/ //g'`
STABLISHED=`netstat -n | grep STABLISHED | wc -l | sed 's/ //g'`

#echo "TIME_WAIT : ${TIME_WAIT}"
#echo "STABLISHED: ${STABLISHED}"

if [ "$TIME_WAIT" -gt $TIME_WAIT_LIMIT ]; then
  SUBJECT="Netstat: Too many TIME_WAIT streams"
  echo "WARNING. Too many TIME_WAIT streams: $TIME_WAIT" >> $MESSAGE
  echo "LIMIT: $TIME_WAIT_LIMIT" >> $MESSAGE
  echo "\n-------------------------------------\n" >> $MESSAGE
  netstat -n  >> $MESSAGE
  /bin/mail -a "X-Priority: 1 (High)" -s "$SUBJECT" "$EMAIL" < "$MESSAGE"
fi

if [ "$STABLISHED" -gt $STABLISHED_LIMIT ]; then
  SUBJECT="Netstat: Too many STABLISHED connections"
  echo "WARNING. Too many STABLISHED connections: $STABLISHED" >> $MESSAGE
  echo "LIMIT: $STABLISHED_LIMIT" >> $MESSAGE
  echo "\n-------------------------------------\n" >> $MESSAGE
  netstat -n  >> $MESSAGE
  /bin/mail -a "X-Priority: 1 (High)" -s "$SUBJECT" "$EMAIL" < "$MESSAGE"
fi

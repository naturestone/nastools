#!/usr/bin/env bash
#
# Script for FreeNAS ab Version 9.9
# Version: FreeBSD 10.3-STABLE 1003510 (uname -orU)

# SCRIPT_DIR setzen
SCRIPT_DIR="`dirname $0`"

# SCRIPT_DIR setzen
SCRIPT_NAME="`basename $0`"

# Default configuration
BASEDIR="$SCRIPT_DIR" 
CONNLOG=${BASEDIR}/../log/connections.log
LOGFILE=${BASEDIR}/../log/smartdown.log
CONFIGFILE=${BASEDIR}/../etc/smartdown.config

# Network
NETWORK_ADDR=192.168.178

# Logger
LOGGER_CMD="`which logger`" 

# Override default configuration
if [ -f "CONFIGFILE" ]; then
. ${CONFIGFILE} 
fi

# Current timestamp
dat=`date "+%Y-%m-%d %H:%M:%S"`

# Check for network connections to the home network
netstat -n | grep -i ESTABLISHED | grep ${NETWORK_ADDR} > ${CONNLOG}
con=$?

# Anzahl der Verbindungen nach Integer umwandeln
ret=$(wc -l < ${CONNLOG})
count=$((ret+0))

function _show_info() {
  # Ausgabe auf stdout
  uptime
  echo
  cat ${CONNLOG}
  echo "---"
  echo "Open: $count"
  echo
}

function _shutdown_now() {

  # Write shutdown console
  echo "$dat --- SMARTDOWN: Shutdown ... " >> $LOGFILE 

  # Shutdown now and  
  shutdown -p now
}

function _test_counter() {
  # Teste, ob keine Verbindungen offen ($count == cin == 0)
  cin="0"
  # Teste auf bestimmte Anzahl cin=$1 an offenen Verbindungen $count
  if [ "$1" != "" ]; then
    cin=${1}
  fi
  # Teste Anzahl offener Verbindungen
  if [ "$count" == "$cin" ]; then
    return 0
  else
    return 1
  fi
}

function _logger_print() {
  # Write to stdout (console)
  echo "smartdown: $1"
  # Write to LOGFILE
  echo "$dat --- SMARTDOWN: $1" >> $LOGFILE 
  if [ -x "$LOGGER_CMD" ]; then
    # Write to syslog
    ${LOGGER_CMD} "smartdown: $1"
  else
    echo "Logger command not valid!"
  fi
}

case "$1" in
    info)
      _show_info
      ;;
    test)
      _test_counter $2
      if [ "$?" == "0" ]; then
        echo "OK"
      else
        echo "FALSE"
      fi
      ;;
    logger)
      _logger_print "($1) Open connections (${count}). Try it later."
      ;;
    safe)
      # Teste, dass keine Verbindungen mehr offen, bevor shutdown 
      _test_counter 0
      if [ "$?" == "0" ]; then
        _logger_print "($1) Shutdown now..."
        _shutdown_now 
      else
        _logger_print "($1) Open connections (${count}). Try it later." 
      fi
      ;;
    now)
      _logger_print "($1) Shutdown now..."
      _shutdown_now
      ;;
    *)
      echo "usage: $SCRIPT_NAME info | test | safe | now | logger "
      exit 1
      ;;
esac

exit 0

#EOF!
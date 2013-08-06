#!/bin/sh

# ---- TEMPLATE ----

# Runs on every Startup after the normal init-steps are done
#  get config file 

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
 echo "------------------ Running $0 ------------------"

if [ "$FTP_ENABLED" = "yes" ] ; then
	echo "starting PROFTPD.."
	# $PROFTPD_CONFIG_FILE
	# $PROFTPD_PID  #####PID#####

#  Define Options
#######  AdminAccess	<-> $ADMIN_ACCESS
#######  AnonAccess	<-> $ENABLE_ANON
#######  SyncAccess	<-> $ENABLE_SYNC

	local proftpd_opt_admin=""
	local proftpd_opt_anon=""
	local proftpd_opt_sync=""

	[ "$ADMIN_ACCESS" = "yes" ] && proftpd_opt_admin="-D AdminAccess"
	[ "$ENABLE_ANON"  = "yes" ] && proftpd_opt_anon="-D AnonAccess"
	[ "$ENABLE_SYNC"  = "yes" ] && proftpd_opt_sync="-D SyncAccess"

	#Proftpd writes the pidfile for its own
	proftpd  -c $PROFTPD_CONFIG_FILE $proftpd_opt_admin $proftpd_opt_admin $proftpd_opt_sync 
	echo $?

fi


#!/usr/bin/env bash
#===============================================================================
# vim: softtabstop=2 shiftwidth=2 expandtab fenc=utf-8 spelllang=en
#===============================================================================
#
#          FILE: sqlplus.sh
#
#   DESCRIPTION: executes the specified sqlplus script on a remote host
#
#===============================================================================

export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P15
export PATH=$PATH:/usr/local/bin:/usr/ccs/bin:/usr/sbin:/usr/ucb:/usr/openwin/bin:/etc:.

# Required arguments
oracle_sid=$1
sqlplus_script=$2

# Optional arguments
username=$3
password=$4

# Check for Oracle SID
if [[ $oracle_sid ]]; then
  export ORACLE_SID=$oracle_sid
  #export ORAENV_ASK=NO
  #. oraenv
else
  printf "ORACLE_SID must be specified \n"
  exit 1
fi

if [[ -z "$username" ]] || [[  -z "$password" ]]; then
  echo exit | sqlplus / as sysdba @$sqlplus_script
else
  echo exit | sqlplus $username/$password@$oracle_sid @$sqlplus_script
fi

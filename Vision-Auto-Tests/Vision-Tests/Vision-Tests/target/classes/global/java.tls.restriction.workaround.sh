#!/bin/sh

#Sourcing consts
VISION_CONSTS_FILE="/opt/radware/mgt-server/bin/vision.consts"

. ${VISION_CONSTS_FILE}

JAVA_SECURITY_FILE="${JAVA_HOME}jre/lib/security/java.security"

function func_modify_security_file {
	local parameter_to_change="$1"
	local text_do_replace="$2"
	local new_text=$3

	if [ ! -f  ${JAVA_SECURITY_FILE} ] ; then
		echo "File ${JAVA_SECURITY_FILE} not found"
		return 1
	fi
	matching_line=`cat $JAVA_SECURITY_FILE |grep -n "^\\s*${parameter_to_change}"`
	if [ -z "${matching_line}" ] ; then
		echo "Field ${parameter_to_change} not found!"
		return 1
	fi
	
	matching_line_id=`echo ${matching_line} | awk -F : '{print $1}'`
	sed -i "${matching_line_id} s/${text_do_replace}/${new_text}/" $JAVA_SECURITY_FILE
	local line_after_change=`cat $JAVA_SECURITY_FILE | sed ${matching_line_id}'q;d'`
	echo "Change result: ${line_after_change}"
}

function func_delete_from_security_file {
	local parameter_to_change="$1"
	local text_do_replace="$2"
	func_modify_security_file "${parameter_to_change}" "${text_do_replace}"  ""
}

func_delete_from_security_file "jdk.certpath.disabledAlgorithms" " MD5," 
func_delete_from_security_file "jdk.tls.disabledAlgorithms" " MD5withRSA," 
echo "Restarting server"
service mgtsrv restart




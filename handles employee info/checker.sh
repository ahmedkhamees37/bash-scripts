##Function takes a parameters. which is file name and return 0 if the file exists
function checkFile {
	FILENAME=${1}
	[ ! -f ${FILENAME} ] && return 1
	return 0
}
##Function takes a parameter which is filename and return 0 if the file has read perm
function checkFileR {
	FILENAME=${1}
	[ ! -r ${FILENAME} ] && return 1
	return 0
}
##Function takes a paremter which is filename and returns 0 if the file has write permission
function checkFileW {
	FILENAME=${1}
        [ ! -w ${FILENAME} ] && return 1
        return 0
}

## Function takes a parameter with username, and return 0 if the user requested is the same as current user
function checkUser {
	RUSER=${1}
	[ ${RUSER} == ${USER} ] && return 0
	return 1
}

### Function takes a username, and password then check them in accs.db, and returns 0 if match otherwise returns 1
function authUser {
	USERNAME=${1}
	USERPASS=${2}
	###1-Get the password hash from accs.db for this user if user found
	###2-Extract the salt key from the hash
	###3-Generate the hash for the userpass against the salt key
	###4-Compare hash calculated, and hash comes from the file.
	###5-IF match returns 0,otherwise returns 1
	USERLINE=$(grep ":${USERNAME}:" accs.db)
	[ -z ${USERLINE} ] && return 0
	PASSHASH=$(echo ${USERLINE} | awk ' BEGIN { FS=":" } { print $3} ')
	SALTKEY=$(echo ${PASSHASH} | awk ' BEGIN { FS="$" } { print $3 } ')
	NEWHASH=$(openssl passwd -salt ${SALTKEY} -6 ${USEPASS})
	if [ "${PASSHASH}" == "${NEWHASH}" ]
	then
		USERID=$(echo ${USERLINE} | awk ' BEGIN { FS=":" } { print $1} ')
		return ${USERID}
	else
		return 0
	fi
}

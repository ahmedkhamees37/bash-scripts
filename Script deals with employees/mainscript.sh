#!/bin/bash
### Script deals with employees
### 
DATAFILE="employee"

declare -A EMPLOYEEA
declare -A SALARYA
source libs/checkers.sh
source libs/fileutils.sh
source libs/dbops.sh

###Function prints all employees
function printAllEmployees {
		echo "ID:Name:Salary"
	for KEY in "${!EMPLOYEEA[@]}"
	do
		local NAME="${EMPLOYEEA[${KEY}]}"
		local SALARY="${SALARYA[${KEY}]}"
		echo "${KEY}:${NAME}:${SALARY}"
	done
}

function printError {
	echo "Error......."
	echo "${1}"
	exit ${2}
}

isFile ${DATAFILE} 
[ ${?} -eq 1 ] && printError "${DATAFILE} is not exist" 1
isRead ${DATAFILE}  
[ ${?} -eq 1 ] && printError "can not read from ${DATAFILE}" 2
isWrite ${DATAFILE}
[ ${?} -eq 1 ] && printError "can not write to ${DATAFILE}" 3


PS3='Please enter your choice: '
options=("Add an employee" "Delete an employee" "Query an employee" "Display all employtees" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add an employee")
		echo -n "Enter employee ID : "
		read employeeID
		###Check ID is an integer
		checkInt ${employeeID}
		if [ ${?} -eq 0  ]
		then
			isExist ${employeeID}
			if [ ${?} -eq 1  ]
			then
				echo -n "Enter employee name: "
				read employeeName
				echo -n "Enter employee salary: "
				read employeeSalary
				checkFloat ${employeeSalary}
				[ ${?} -eq 0 ] && addEmployee ${employeeID} "${employeeName}" ${employeeSalary} || printError "Invalid salary value" 4
			else
				echo "${employeeID} is already exist"
			fi
		else
			echo "The employee ID must be an integer"
		fi
            ;;
        "Delete an employee")
            echo "Delete an employee"
            ;;
        "Query an employee")
            echo "Query an employee"
            ;;
	"Display all employtees")
		readAllEmployees	
		printAllEmployees
		;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done



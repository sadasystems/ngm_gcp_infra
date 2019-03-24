#!/bin/bash
set -e
ret_code=0

if [ -z ${TF_VAR_project_id+x} ]; then 
    echo "ERROR: required variable: \$TF_VAR_project_id is unset!"; 
    ret_code=1
else 
    echo "INFO: variable: \$TF_VAR_project_id is set to '$TF_VAR_project_id'"; 
fi

if [ -z ${TF_VAR_bucket+x} ]; then 
    echo "ERROR: required variable: \$TF_VAR_bucket is unset!"; 
    ret_code=1
else 
    echo "INFO: variable: \$TF_VAR_bucket is set to '$TF_VAR_bucket'"; 
fi

exit ${ret_code}
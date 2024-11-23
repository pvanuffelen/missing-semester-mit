#!/usr/bin/env bash

echo "Running $0"

echo "Resetting counter"
counter=0

out_file="output.log"
err_file="error.log"

while true;do
  counter=$((counter + 1))
  
  ./my_script.sh > temp_out.log 2> temp_err.log
  exit_code=$?

  if [[ ${exit_code} -ne 0 ]]; then
    cat temp_out.log > "${out_file}"
    cat temp_err.log > "${err_file}"

    rm temp_out.log temp_err.log
    
    break
  fi

  # clean up temporary files if the script didn't fail
  rm temp_out.log temp_err.log

done

echo "Script failed after ${counter} times"
echo "--- STDOUT ---"
cat "${out_file}"
echo "--- STDERR ---"
cat "${err_file}"


#!/usr/bin/env sh

function verify_exists() {
  which $1 > /dev/null 2> /dev/null

  if [[ $? != 0 ]]; then
    echo Could not find executable: ${1}
    exit
  fi
}

initial_working_directory="$(pwd)"

cd "$(dirname $0)"
project_root="$(pwd)"

# Check for dependencies
# verify_exists coffee
# verify_exists stylus
verify_exists jade

mkdir -p scripts styles

coffee -o "${project_root}/scripts/" -c "${project_root}/src/scripts/"
stylus -o "${project_root}/styles"      "${project_root}/src/styles" 
jade   -O "${project_root}/"            "${project_root}/src/"                     &

# Restore original state. Why? WHY NOT?!
cd "${initial_working_directory}"


#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
user_root_dir=${script_dir}"/user_root"

cp -R -v ${user_root_dir}/ ~/
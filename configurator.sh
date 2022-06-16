#!/bin/bash

pkg_dir="remote-logging-config"

prepare() {
	rm -rf $pkg_dir
	mkdir $pkg_dir
	cp "cmd/$1.cli" "${pkg_dir}/run.cli"
	cp "cfg/$2.properties" "${pkg_dir}/config.properties"
	cp "scripts/cli.sh" "${pkg_dir}/cli.sh"
	cp "scripts/init.sh" "${pkg_dir}/init.sh"
	local docker_name=$(grep "^$3.wfly.docker" configurator.properties | cut -d '=' -f2)
	sed -i "s/DOCKER_NAME/${docker_name}/g" "${pkg_dir}/init.sh"
	tar --exclude='init.sh' -cf $pkg_dir.tar $pkg_dir/ 
}

apply() {
	local tar_path="/tmp/logging-config.tar" 
	local sh_path="/tmp/logging-init.sh"
	scp $pkg_dir.tar $1:$tar_path
	scp $pkg_dir/init.sh $1:$sh_path
	ssh -tt $1 "sh $sh_path $tar_path"
}

case $1 in
	help)
		echo "Usage: $0 <command> <log category alias> <host or its alias>"
		echo "Available commands:"
		ls cmd | cut -f1 -d '.'
		;;
	*)
		prepare $1 $2 $3

		host_file="hosts/$3"
		if [ -f "$host_file" ]; then
			while read line; do
				lines=( "${lines[@]}" "$line" )
			done < $host_file
			
			for line in "${lines[@]}"
			do
				echo "Applying to $line"
				apply $line
			done
		else
			apply $3
		fi
		;;
esac


# Remote WildFly logger configurator

## The motivation behind this utility

There are cases when you want to add some logger category on the fly on a remote WildFly instance, investigate what you need and then remove it. Also, quite often, you have to do this on more than one instance. And it is not rare case that these instances are inside Docker containers. So, for each instance, you need to:
- ssh to remote server
- go inside Docker container
- then execute lengthy command (you are lucky if you remember all details)
- do with logs what you need
- repeat first 3 steps to remove added logger category

It's boring and error-prone activity that deters your investigations. No more :)

## The solution

Introduce extensible framework to define commands that operate on logger categories and make these commands configurable. This allow to apply the same command for any logger category. Also track all server instances in one file. 
You defined commands in \*.cli files under `cmd` directory. The name of file determines command's name. You define configurations in \*.properties files under `cfg` directory. The name of file is an alias for logger category. Finally, you define servers' group in text file without extension and store it under `hosts` directory. The name of file determines servers' group name.

Then you can issue `./configurator.sh <command> <logger category alias> <host or its alias>`

and this will execute command for specified logger category on each WildFly instance in the specified group.

E.g. `./configurator.sh enable ispnCfg stg`

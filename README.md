# Remote WildFly logger configurator

## The motivation behind this utility

There are cases when you want to add some logger category on the fly on a remote WildFly instance, investigate what you need and then remove it. Also, quite often, you have to do this on more than one instance. And it is not rare case that these instances are inside Docker containers. So, for each instance, you need to:
- ssh to remote server
- go inside Docker container
- then execute lengthy command (you are lucky if you remember all details)
- do with logs what you need
- repeat first 3 steps to remove added logger category

It's boring and error-prone activity that deters your investigations. No more :)

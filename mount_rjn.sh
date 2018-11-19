# https://github.com/libfuse/sshfs
if [ -e ~/rjn ] ; then
	umount ~/rjn
	if [ -e ~/rjn ] ; then
		mv ~/rjn ~/rjn.$(date -Iminutes)
	fi
fi
sshfs rjn:/g/data/gx8/ ~/rjn

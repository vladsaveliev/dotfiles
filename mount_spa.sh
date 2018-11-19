# https://github.com/libfuse/sshfs
if [ -e ~/spa ] ; then 
	umount ~/spa
	if [ -e ~/spa ] ; then
		mv ~/spa ~/spa.$(date -Iminutes)
	fi
fi
sshfs spa:/data/cephfs/punim0010/ ~/spa


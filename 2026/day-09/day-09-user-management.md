useradd -m

Create user with home directory.

passwd

Set password.

groupadd

Create group.

usermod -aG

Add user to group.

groups username

Check group membership.

chmod 775

Give:

owner = rwx
group = rwx
others = r-x
chgrp

Change group ownership.

sudo -u username

Run command as another user.

# challenges faced

permission denied while creating files
solved using proper group permission and chmod 775

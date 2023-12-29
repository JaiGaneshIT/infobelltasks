## Installing applications on first logon by users
### Creating a bash script to automate the installation process.
 > Listed application should be installed :
  * openssh-server
  * net-tools
  * Docker-Engine
> Targeted distro's RHEL and Debian.

### Summary
 * The script is created to run on both flavors .rpm and .deb
 * firstly the process will check for the packages presences
 * perhaps not the prompt will appear to the user permission to install
 * And it'll check the flavor and based on that the functions will invoke.
 * if the packages already there , it'll skip the installation and go on.
 * And finally ,the installation will get complete successful.

## prerequisite
 * Repo's should be up-to-date.

#!/bin/bash

# NOTE: USE AT YOUR OWN RISK, this script will overwrite your Drupal install.
#
# This bash script will allow you to overwrite you current core Drupal files with
# the latest Pressflow 6.x release in a sane manner.
#
# Please backup your site prior to running this script just in case and
# be sure to adjust the skips as needed. You will need to merge your
# customizations back in manually otherwise.
#
# Run this script from within the Drupal root that you wish to update.
# $ cp /path/to/pressflow6-switchover.sh /path/to/drupal
# $ ./path/to/drupal/pressflow6-switchover.sh
#
# First the script pulls down the latest Pressflow archive from Github.
#
# Then it uses rsync to overwrite the existing core files. This is made SVN safe
# by the exclusion of .svn directories from the sync.
#
# I've listed every root level directory individually so you can skip specific ones
# by commenting them out. The common /sites and .htaccess are defaults.


# Download and unpack the latest Pressflow archive from Github.
curl -Lk -o master.zip https://github.com/pressflow/6/archive/master.zip
unzip master.zip

# Skip any customized files by commenting them out such as .htaccess or your
# robots.txt file.
#mv 6-master/robots.txt ./
#mv 6-master/.htaccess ./
mv 6-master/CHANGELOG.txt ./
mv 6-master/COPYRIGHT.txt ./
mv 6-master/cron.php ./
mv 6-master/index.php ./
mv 6-master/INSTALL.mysql.txt ./
mv 6-master/INSTALL.pgsql.txt ./
mv 6-master/install.php ./
mv 6-master/INSTALL.txt ./
mv 6-master/LICENSE.txt ./
mv 6-master/MAINTAINERS.txt ./
mv 6-master/update.php ./
mv 6-master/UPGRADE.txt ./
mv 6-master/xmlrpc.php ./

# Use rsync to sync files and remove extras that would be orphaned. Exclude
# .svn directories in case we are under SVN version control.
rsync -avzpP --delete --exclude '.svn' 6-master/includes ./
rsync -avzpP --delete --exclude '.svn' 6-master/misc ./
rsync -avzpP --delete --exclude '.svn' 6-master/modules ./
rsync -avzpP --delete --exclude '.svn' 6-master/profiles ./
rsync -avzpP --delete --exclude '.svn' 6-master/scripts ./
rsync -avzpP --delete --exclude '.svn' 6-master/themes ./
#rsync -avzpP 6-master/sites ./

# Cleanup
rm -r 6-master master.zip

# If you have drush installed you may want to run the database update command.
#drush updatedb -y

#!/bin/bash

# NOTE: USE AT YOUR OWN RISK, this script will overwrite your Drupal install.
#
# This bash script will allow you to overwrite you current core Drupal files with
# the latest Pressflow release in a sane manner.
#
# Please backup your site prior to running this script just in case and
# be sure to adjust the skips as needed. Be sure to move any files you may have
# customized, you will need to merge your changes back manually.
#
# Run this script from within the Drupal root that you wish to update.
# $ cp /path/to/pressflow6-switchover.sh /path/to/drupal
# $ ./path/to/drupal/pressflow6-switchover.sh
#
# First the scritp pulls down the latest Pressflow archive from Github.
#
# Then it uses rsync to overwrite the existing core files. This is made SVN safe
# by the exclusion of .svn directories from the sync.
#
# I've listed every root level directory individually so you can skip specific ones
# by commenting them out. The common /sites and .htaccess are defaults.


# Download and unpack the latest Pressflow archive from Github.
curl -C - -o master.tar.gz https://nodeload.github.com/pressflow/6/tar.gz/master
tar -zxvf master.tar.gz

# Use rsync to sync files and remove extras that would be orphaned. Exclude
# .svn directories in case we are under SVN version control.
# To Do - work it out so that robots.txt can be skipped easily.
mv 6-master/*.txt ./
mv 6-master/*.php ./
rsync -avzpP --delete --exclude '.svn' 6-master/includes ./
rsync -avzpP --delete --exclude '.svn' 6-master/misc ./
rsync -avzpP --delete --exclude '.svn' 6-master/modules ./
rsync -avzpP --delete --exclude '.svn' 6-master/profiles ./
rsync -avzpP --delete --exclude '.svn' 6-master/scripts ./
rsync -avzpP --delete --exclude '.svn' 6-master/themes ./

# Skip any customized files. You certainly don't want to overwrite /sites
#mv pressflow/.htaccess ./
#rsync -avzpP pressflow/sites ./

# Cleanup
rm -r 6-master master.tar.gz

# If you have drush installed you may want to run the database update command.
#drush updatedb -y

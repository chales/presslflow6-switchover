#!/bin/bash

# This script will allow you to overwrite you current core Drupal files with the
# latest Pressflow release in a sane manner.
#
# First we pull down the latest Pressflow archive from Github.
#
# We use rsync to overwrite out existing core files and this make SVN safe by
# the exclusion of .svn from the sync.
#
# Run this script from within the Drupal root that you wish to update.
# $ cp /path/to/pressflow-switch.sh /path/to/drupal
# $ ./path/to/drupal/pressflow-switch.sh
#
# NOTE: Please backup your site prior to running this script just in case and
# be sure to adjust the skips as needed. Comment out any files you may have
# customized, you will need to merge your changes manually for those.

# Download and unpack the latest Pressflow from Github.
curl -C - -o master.tar.gz https://nodeload.github.com/pressflow/6/tar.gz/master
tar -zxvf master.tar.gz

# Use rsync to sync files and remove extras that should be orphaned. Exclude
# .svn directories in case we are under version control.
mv pressflow/*.txt ./
mv pressflow/*.php ./
rsync -avzpP --delete --exclude '.svn' 6-master/includes ./
rsync -avzpP --delete --exclude '.svn' 6-master/misc ./
rsync -avzpP --delete --exclude '.svn' 6-master/modules ./
rsync -avzpP --delete --exclude '.svn' 6-master/profiles ./
rsync -avzpP --delete --exclude '.svn' 6-master/scripts ./
rsync -avzpP --delete --exclude '.svn' 6-master/themes ./

# Skip any customized files
#mv pressflow/.htaccess ./
#rsync -avzpP pressflow/sites ./

# Cleanup
rm -r 6-master master.tar.gz

# If you have drush installed you may want to run the database update and cache
# clear commands.
#drush updatedb -y
#drush cache-clear all

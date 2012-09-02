#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

package 'python-software-properties python-lxml'
include_recipe 'python'

# Install MySQLdb
remote_file "/usr/local/src/MySQL-python-1.2.3.tar.gz" do
  source "http://downloads.sourceforge.net/project/mysql-python/mysql-python/1.2.3/MySQL-python-1.2.3.tar.gz"
  action :create_if_missing
end

bash "install translation toolkit" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd /usr/local/src
    tar xjf MySQL-python-1.2.3.tar.gz
    cd MySQL-python-1.2.3
    python setup.py install
  EOH
end

# Install South
execute "pip install south" do
  command "pip install south"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install Django Voting
execute "pip install django-voting" do
  command "pip install django-voting"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install Django Web Assets
execute "pip install webassets" do
  command "pip install webassets"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install CSS min
execute "pip install cssmin" do
  command "pip install cssmin"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install Python Levenstein
package "python-levenshtein"

# Install Python Memcached
package "python-memcache"
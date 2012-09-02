#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

# Install MySQLdb
remote_file "/usr/local/src/MySQL-python-1.2.3.tar.gz" do
  notifies :run, "bash[install mysql python]"
  source "http://downloads.sourceforge.net/project/mysql-python/mysql-python/1.2.3/MySQL-python-1.2.3.tar.gz"
  action :create_if_missing
end

bash "install mysql python" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd /usr/local/src
    tar xjf MySQL-python-1.2.3.tar.gz
    cd MySQL-python-1.2.3
    python setup.py install
  EOH
  action :nothing
end
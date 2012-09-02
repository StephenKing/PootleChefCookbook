#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

# https://www.djangoproject.com/download/1.3.3/tarball/
remote_file "/usr/local/src/Django-1.3.3.tar.gz" do
  source "https://www.djangoproject.com/download/1.3.3/tarball/"
  action :create_if_missing
end

bash "install django" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd /usr/local/src
    tar xzf Django-1.3.3.tar.gz
    cd Django-1.3.3
    python setup.py install
  EOH
end
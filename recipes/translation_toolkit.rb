#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

remote_file "/usr/local/src/translate-toolkit.tar.bz2" do
  notifies :run, "bash[install translation toolkit]"
  source "http://downloads.sourceforge.net/project/translate/Translate%20Toolkit/1.9.0/translate-toolkit-1.9.0.tar.bz2"
  action :create_if_missing
end

bash "install translation toolkit" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd /usr/local/src
    tar xjf translate-toolkit-1.9.0.tar.bz2
    cd translate-toolkit-1.9.0
    python setup.py install
  EOH
  action :nothing
end
#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

%w{sun-java5-jdk g++ python-dev subversion jcc ant make}.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "/usr/local/src/pylucene-2.9.4-1-src.tar.gz" do
  source "http://apache.mirror.testserver.li//lucene/pylucene/pylucene-2.9.4-1-src.tar.gz"
  action :create_if_missing
end

bash "install pylucene" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd /usr/local/src
    svn co http://svn.apache.org/repos/asf/lucene/pylucene/trunk/jcc jcc
    cd jcc
    ln -s /usr/lib/jvm/java-6-sun /usr/lib/jvm/java-1.5.0-sun
    patch -d /usr/local/lib/python2.6/dist-packages/distribute-0.6.28-py2.6.egg -Nup0 < /usr/local/src/jcc/jcc/patches/patch.43.0.6c7
    JCC_JDK="/usr/lib/jvm/java-6-sun" python setup.py build
    JCC_JDK="/usr/lib/jvm/java-6-sun" python setup.py install
    
    cd /usr/local/src
    tar xzvf pylucene-2.9.4-1-src.tar.gz
    cd pylucene-2.9.4-1/
    pushd jcc/
  EOH
end
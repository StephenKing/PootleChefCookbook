#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

# java 5 ?
%w{sun-java5-jdk g++ python-dev subversion jcc ant make}.each do |pkg|
  package pkg
end

remote_file "/usr/local/src/pylucene-2.9.4-1-src.tar.gz" do
  # could make this an attribute
  source "http://apache.mirror.testserver.li//lucene/pylucene/pylucene-2.9.4-1-src.tar.gz"
  action :create_if_missing
  notifies :b
end

# you could/should refactor this a bit
# - split up into jcc and pylucene
# - run only if there is work to do, so either add a not_if { ::File.exists?(/usr/local/src/jcc) } or use action :nothing plus a notification of the above resource
# - use the link resource instead of `ln`
# - use the scm subversion provider (and remove `package subversion` above)

# I hope to find time the next days to give this a try
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

#
# Cookbook Name:: tmux
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "tmux" do
  action :install
end

template ".tmux.conf" do
  path "/home/vagrant/.tmux.conf"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

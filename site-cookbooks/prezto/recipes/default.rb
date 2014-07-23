#
# Cookbook Name:: prezto
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "/home/vagrant/.zprezto" do
  repository "https://github.com/sorin-ionescu/prezto"
  reference "master"
  user 'vagrant'
  group 'vagrant'
  action :sync
  not_if "test -d /home/vagrant/.zprezto"
end

bash "zprezto_submodule" do
  user 'vagrant'
  group 'vagrant'
  cwd "/home/vagrant/.zprezto"
  code <<-EOH
  git pull
  git submodule update --init --recursive
  EOH
end

template "zpreztorc" do
  path "/home/vagrant/.zprezto/runcoms/zpreztorc"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

template "zshrc" do
  path "/home/vagrant/.zprezto/runcoms/zshrc"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

template ".zshrc.local" do
  path "/home/vagrant/.zshrc.local"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

%w{ zshenv zshrc zlogin zlogout zpreztorc zprofile}.each do |rcfile|
  execute "install /home/vagrant/#{rcfile}" do
    cwd "/home/vagrant"
    command "ln -s /home/vagrant/.zprezto/runcoms/#{rcfile} /home/vagrant/.#{rcfile}"
    not_if { ::File.exists?("/home/vagrant/.#{rcfile}")}
  end
end

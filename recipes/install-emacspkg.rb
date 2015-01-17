#
# Cookbook Name:: cookbook-cask
# Recipe:: install-emacspkg
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# .emacs.d
directory "/home/#{node['user']}/.emacs.d/" do
  owner node['user']
  group node['group']
  mode "0755"
  action :create
  not_if { File.exists?("/home/#{node['user']}/.emacs.d") }
end

# Cask
template "/home/#{node['user']}/.emacs.d/Cask" do
  source "Cask.erb"
  owner node['user']
  group node['group']
  mode "0644"

  not_if { File.exists?("/home/#{node['user']}/.emacs.d/Cask") }
  notifies :run, "execute[install emacs package]", :immediately
end

execute "install emacs package" do
  user node['user']
  group node['group']
  environment "HOME" => "/home/#{node['user']}"

  cwd "/home/vagrant/.emacs.d"
  command <<-EOH
  $HOME/.cask/bin/cask upgrade-cask
  $HOME/.cask/bin/cask
  EOH

  action :nothing
end

#
# Cookbook Name:: cookbook-cask
# Recipe:: install-emacspkg
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "install emacs package" do
  user "#{node['user']}"
  group "#{node['user']}"
  environment "HOME" => "/home/#{node['user']}"

  cwd "/home/vagrant/.emacs.d"
  command <<-EOH
  export PATH="$HOME/.cask/bin:$PATH"
  cask upgrade-cask
  cask
  EOH
end

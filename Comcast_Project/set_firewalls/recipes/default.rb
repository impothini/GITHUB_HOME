#
# Cookbook Name:: set_firewalls
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

firewall 'default'

# enable default firewall
firewall 'default' do
  action :install
end

#Allow ssh only from home

firewall_rule 'allow ssh from home' do
  port 22
  source '68.231.88.70'
end

#Expose port 80 to public

firewall_rule 'http' do
  port     80
  protocol :tcp
  position 1
  command  :allow
end

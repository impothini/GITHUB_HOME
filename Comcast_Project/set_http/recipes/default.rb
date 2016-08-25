#
# Cookbook Name:: set_http
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#check if "httpd" is installed. if not, install is default.

package 'httpd'

#Enable httpd service on boot and starting service

service 'httpd' do
  action [:enable, :start]
end

## Writing given html code to index.html 

file '/var/www/html/index.html' do
	content '<html>
<head>
<title>Hello World</title>
</head>
<body>
<h1>Hello World!</h1>
</body>
</html>'
end

#loading desired httpd.conf 

template "/etc/httpd/conf/httpd.conf" do
  		source "httpd.conf.erb"
end

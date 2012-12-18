
package "motion"

template "/etc/motion/motion.conf" do
  source "motion.conf.erb"
  variables node[:motion]

  notifies :restart, "service[motion]", :delayed
end

file "/etc/default/motion" do
  owner "root"
  group "root"
  mode "0644"

  content "start_motion_daemon=yes"
end

node[:motion][:threads].each do |name, conf|

  template "/etc/motion/thread-#{name}.conf" do
    owner "root"
    group "motion"
    mode "0640"
    source "motion-thread.conf.erb"
    variables Mash.new(:name => name).merge(conf)

    notifies :restart, "service[motion]", :delayed
  end

end

service "motion" do
  supports :status => true, :restart => true, :reload => true
  action :start
end

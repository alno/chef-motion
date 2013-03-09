
directory "/etc/motion" do
  owner "root"
  group "motion"
  mode "0750"
end

template "/etc/motion/motion.conf" do
  owner "root"
  group "motion"
  mode "0640"

  source "motion.conf.erb"
  variables node[:motion]

  notifies :restart, "service[motion]", :delayed
end

file "/etc/default/motion" do
  owner "root"
  group "root"
  mode "0640"

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

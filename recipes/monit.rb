
include_recipe "monit"

monitrc "motion" do
  source "motion.monitrc.erb"
  variables node[:motion]
end

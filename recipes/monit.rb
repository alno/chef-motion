
include_recipe "monit"

monit_monitrc "motion" do
  template_source "motion.monitrc.erb"
  variables node[:motion]
end

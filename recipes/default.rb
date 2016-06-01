package 'motion'

service 'motion' do
  supports status: true, restart: true, reload: true
  action :start
end

include_recipe 'motion::config'

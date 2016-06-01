source_dir = Chef::Config['file_cache_path'] || '/tmp'

package %w(libavcodec-dev libavformat-dev libjpeg-dev libpq-dev libv4l-dev dpkg-dev)

group 'motion'
user 'motion' do
  gid 'motion'
  system true
  shell '/bin/false'
end

group 'video' do
  action :modify
  members 'motion'
  append true
end

template '/etc/init.d/motion' do
  source 'motion.init.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables node['motion']
end

service 'motion' do
  supports status: true, restart: true, reload: true
  action :start
end

include_recipe 'motion::config'

bash 'compile_motion' do
  cwd source_dir
  code <<-EOH
    ln -s /usr/lib/*/{libavcodec,libavformat}.{a,so} /usr/lib

    rm -rf motion-*
    apt-get source motion
    cd motion-*

    wget http://www.lavrsen.dk/foswiki/pub/Motion/OggTimelapse/ogg_theora_codec.diff
    patch < ogg_theora_codec.diff

    ./configure --prefix #{node['motion']['prefix']}
    make && make install
  EOH

  not_if { ::File.exist? "#{node['motion']['prefix']}/bin/motion" }

  notifies :restart, 'service[motion]'
end

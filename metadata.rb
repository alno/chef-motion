name             'motion'
maintainer       'Alexey Noskov'
maintainer_email 'alexey.noskov@gmail.com'
license          'MIT'
description      'Installs Motion, a software motion detector.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
source_url       'https://github.com/alno/chef-motion' if respond_to?(:source_url)
issues_url       'https://github.com/alno/chef-motion' if respond_to?(:issues_url)

recipe 'motion',          'Set up the motion server'
recipe 'motion::monit',   'Monit config for motion server'

supports 'ubuntu'

depends 'monit'

name             "motion"
maintainer       "Alexey Noskov"
maintainer_email "alexey.noskov@gmail.com"
license          "MIT"
description      "Installs Motion, a software motion detector."
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.0"

recipe "motion",          "Set up the motion server"
recipe "motion::monit",   "Monit config for motion server"

supports "ubuntu"

recommends "monit"

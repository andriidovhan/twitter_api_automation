How to use:
- install rvm(https://rvm.io/);
- pull this repo;
- Do not forget to add your own conf.yml file according to the provided examples in the config folder.

ENV variables:

CONF_PATH - path to custom config file

DEBUG - enable pry debugging (any value)


How to run(example):

rspec spec/...

or

CONF_PATH=/tmp/custom_config.yml rspec spec/...

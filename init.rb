

APP_ROOT = File.dirname(__FILE__)


# Wherever you are just add /lib and that will allow to open this file (init.rb)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))
require 'bike_europe'


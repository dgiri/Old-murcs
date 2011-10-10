require 'ostruct'
require 'yaml'

config = OpenStruct.new(YAML.load_file("#{Rails.root}/config/config.yml"))
::AppConfig = OpenStruct.new(config.send(Rails.env))


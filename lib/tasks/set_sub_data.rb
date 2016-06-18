#encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"
require 'open-uri'    
    tags = OverTag.where(is_create_data: false)
    tags.each do |tag|
      OverTag.set_sub_data(tag)
    end

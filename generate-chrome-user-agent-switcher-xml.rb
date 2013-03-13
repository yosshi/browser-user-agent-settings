# -*- coding: utf-8 -*-
# Generate XML for Chrome and Firefox User-Agent Switcher Add-on.
# https://chrome.google.com/webstore/detail/user-agent-switcher-for-c/djflhoibgkdhkhhcedjiklpkjnoahfmg
# <useragent description="" appcodename="" appname="" appversion="" platform="" vendor="" vendorsub=""/>
# TODO: Safari とコードを共通化

#Sample XML
#<useragentswitcher>
#  <folder description="Browsers - Windows">
#    <folder description="Legacy Browsers">
#      <useragent description="Avant Browser 1.2" useragent="Avant Browser/1.2.789rel1 (http://www.avantbrowser.com)" appcodename="" appname="" appversion="" platform="" vendor="" vendorsub=""/>
#    </folder>
#  </folder>
#</useragentswitcher>

require 'csv'
require 'libxml'


def generate_setting_xml android_user_agents
  carriers         = ['docomo', 'au', 'Softbank']
  setting_xml      = LibXML::XML::Document.new
  setting_xml.root = LibXML::XML::Node.new('useragentswitcher')

  root = setting_xml.root

  carriers.each do |carrier|

    # folder
    root << folder = LibXML::XML::Node.new('folder')
    folder['description'] = "Android - #{carrier}"
    carrier_android_user_agents = list_filter_carrier android_user_agents, carrier

    # folder - useragent 
    carrier_android_user_agents.each do |android|
      if !android['pre-install browser'].nil?
        folder << useragent = LibXML::XML::Node.new('useragent')
        useragent['description'] = "#{android['model']} - #{android['os_version']}"
        useragent['useragent']   = android['pre-install browser']
        useragent['appcodename'] = ""
        useragent['appname']     = "" 
        useragent['appversion']  = "" 
        useragent['platform']    = ""
        useragent['vendor']      = "" 
        useragent['vendorsub']   = ""
      end
    end

  end

  setting_xml
end


def list_filter_carrier android_user_agents, carrier
  filtered_list = []
  android_user_agents.each do |android|
    if android['carrier'] == carrier
      filtered_list << android
    end
  end

  filtered_list
end


options = {
  headers:    true,
  col_sep:    "\t",
  quote_char: '"'
}

android_user_agents = CSV.open('./android_ua.tsv', 'r', options).to_a
puts generate_setting_xml android_user_agents

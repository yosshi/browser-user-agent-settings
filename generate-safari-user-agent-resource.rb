# -*- coding: utf-8 -*-
# Safari(Mac) User-Agents Setting plist
# /Applications/Safari.app/Contents/Resources/UserAgents.plist
# thor とか使ったほうがいいんじゃないの

require 'csv'
require 'plist'

def generate_safari_user_agents_plist android_user_agents
  # plist format
  #  {"name" => "Safari", 
  #  "version" => "6.0.2",
  #  "platform" => "Mac",
  #  "user-agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.26.17 (KHTML, like Gecko) Version/6.0.2 Safari/536.26.17"}

  safari_user_agents_settings = Plist::parse_xml('/Applications/Safari.app/Contents/Resources/UserAgents.plist')
  android = useragents_for_plist android_user_agents

  safari_user_agents_settings.concat split_bar
  safari_user_agents_settings.concat android
  safari_user_agents_settings.to_plist
end


def self.split_bar
  [{"separator"=>true}]
end

def useragents_for_plist android_user_agents
  user_agents = []
  android_user_agents.each do |android|
    if !android['pre-install browser'].nil?
      user_agents <<  {
        'name'       => android['model'],
        'version'    => android['os_version'],
        'platform'   => "Android #{android['carrier']}",
        'user-agent' => android['pre-install browser']
      }
    end
  end
  user_agents
end


options = {
  headers:    true,
  col_sep:    "\t",
  quote_char: '"'
}

android_user_agents = CSV.open('./android_ua.tsv', 'r', options)
puts generate_safari_user_agents_plist android_user_agents


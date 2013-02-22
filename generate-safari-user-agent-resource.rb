# Safari(Mac) User-Agents Setting plist
# /Applications/Safari.app/Contents/Resources/UserAgents.plist

require 'csv'

options = {
  headers:    true,
  col_sep:    "\t",
  quote_char: '"'
}

android_user_agents = CSV.open('./android_ua.tsv', 'r', options)

android_user_agents.each do |h|
p h
end



def generate_safari_user_agents_plist android_user_agents

end

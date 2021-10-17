# GET /issue-label-badges/README.md

require 'rest-client'
require 'json'

def create_badges(per_page, page)
  url_fmt = 'https://api.github.com/repos/diylove/wiki/labels?per_page=%s&page=%s'

  api_url = url_fmt % [per_page, page]
  all_labels = JSON.parse(RestClient.get api_url || [])

  all_labels.map do |i|
    name = i['name'].sub('：', '-').gsub(/\s+/, '').gsub('#', '%23')
    url = "https://img.shields.io/badge/#{name}-#{i['color']}"
    puts "* ![](#{url})"
  end

  create_badges(per_page, page + 1) if all_labels.size.equal?(per_page)
end

puts "# Wiki Issue Tags Badges List"

per_page = 100
page = 1
create_badges(per_page, page)


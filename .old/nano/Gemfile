source 'https://rubygems.org'
ruby '2.7.8'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rake'
gem 'stringex'
gem 'highline'
gem 'dotenv'
gem 'zotero', github: 'micapam/zotero'
gem 'activesupport'
# RestClient 2.0 compatibility - https://github.com/crohr/rest-client-components/pull/14
gem 'rest-client-components', github: 'amatriain/rest-client-components', ref: '236ac31e'
gem 'rack-cache'

group :nanoc do
  gem 'nanoc', '~> 4.7'
  gem 'guard-nanoc'
  gem 'adsf'
  gem 'kramdown'
  gem 'sanitize'
  gem 'fog'
end

require 'stringex'
require 'highline'

desc "Create a new post"
task :new_post, :title, :date do |t, args|
  mkdir_p './content/posts'
  args.with_defaults(title: 'New Post', date: Time.now.to_s)
  title = args.title
  date = Date.parse args.date
  filename = "./content/posts/#{date.strftime('%Y-%m-%d')}-#{title.to_url}.md"

  if File.exist?(filename)
    abort('rake aborted!') if ask("#{filename} already exists. Want to overwrite?", ['y','n']) == 'n'
  end

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts <<EOF
---
title: "#{title}"
created_at: #{date}
thumb:
kind: article
published: true
source:
  url:
  publication:
---
EOF
  end
end
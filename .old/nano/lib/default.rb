require 'dotenv/load'
require 'active_support/core_ext/string/inflections'

include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo

module PostHelper
  def posts(tag: nil, include_books: false)
    sorted_articles.select do |article|
      next false if !include_books && article[:tags].include?('book')
      next false if tag.present? && !article[:tags].include?(tag)
      next false if article[:tags].include?('hidden')

      true
      # (tag.nil? || article[:tags].include?(tag)) &&
      #   (include_books || !article[:tags].include?('book'))
    end
  end

  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def get_post_description(post)
    if %w[\/ /essays/ /fiction/ /poetry/ /archive/].include? post.path
      'Joshua Mostafa\'s latest work.'
    elsif post[:teaser]
      post[:teaser]
    else
      "#{Sanitize.clean(post.compiled_content).split(/\s+/).first(50).join(' ')}..."
    end
  end

  def get_bibliography_layout(entry)
    known_entry_types = %w(
      blog_post
      book
      book_section
      journal_article
      newspaper_article
      thesis
      video_recording
      webpage)

    layout = if known_entry_types.include?(entry.kind)
      entry.kind
    else
      'default'
    end

    #TODO choose other style guides via config
    "/bibliography/chicago/#{layout}.*"
  end

end

include PostHelper
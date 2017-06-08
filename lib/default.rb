include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo

module PostHelper

  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def get_post_description(post)
    case post.path
    when '/', '/essays/', '/fiction/', '/poetry/', '/reviews/'
      'Joshua Mostafa\'s latest work.'
    else
      "#{Sanitize.clean(post.compiled_content).gsub(/\s+/, ' ')[0..110]}..."
    end
  end

end

include PostHelper
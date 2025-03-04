require 'zotero'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/string/inflections'
require 'restclient/components'
require 'rack/cache'

class ZoteroDataSource < ::Nanoc::DataSource
  identifier :zotero

  def up 
    unless ENV['ZOTERO_USER_ID'] && ENV['ZOTERO_KEY']
      raise 'Env vars ZOTERO_USER_ID and ZOTERO_KEY must be set'
    end

    RestClient.enable Rack::Cache, default_ttl: 2.hours
    @library = ::Zotero::Library.new ENV['ZOTERO_USER_ID'], ENV['ZOTERO_KEY']
  end

  def items
    @library.collections.select do |collection|
      next false if ENV['ZOTERO_SKIP']
      @config[:collections].collect{|c| c[:name]}.include? collection.name
    end.collect do |collection| 
      collection.preload # Don't break nanoc's frozen data rule

      description = @config[:collections].find {|c|
        c[:name] == collection.name
      }[:description]

      new_item(
        '',
        { collection: collection, description: description },
        "/#{collection.name.parameterize}"
      )
    end
  end
end

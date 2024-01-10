require 'cgi'

module Florby
  module Plugins
    class WikiLinkReplacer
      WIKI_LINK_REGEXP = /\[\[\s?([^\[\]\|\n\r]+)(\|[^\[\]\|\n\r]+)?\s?\]\]/

      def initialize(collection:)
        @collection = collection
      end

      def replace!
        @collection.all_pages.each do |page|
          page.meta['backlinks'] ||= []

          page.content =
            page.content.gsub(WIKI_LINK_REGEXP) do |match|

              title = CGI.unescapeHTML(Regexp.last_match(1))
              destination = @collection.find(title)

              unless page.exclude_from_collections?
                destination.meta['backlinks'] ||= []
                destination.meta['backlinks'] << page
              end

              raise "Page not found: #{title}. #{@collection.titles}" unless destination

              "<a href='#{destination.permalink}'>#{destination.title}</a>"
            end
        end
      end
    end
  end
end

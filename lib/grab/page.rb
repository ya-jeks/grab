require 'nokogiri'
require 'open-uri'

module Grab
  class Page
    attr_reader :html, :address

    def initialize(url)
      @html = open url
      @address = URI.parse url
    end

    def images
      list = source_links.reduce([]) do |res, link|
        url = relative_path?(link) ? address.merge(link) : link
        res << url
      end
      list.uniq
    end

    protected
      def source_links
        doc = Nokogiri::HTML html
        doc.xpath('//img').map{|e| e['src'] }
      end

      def relative_path?(url)
        url[0..3] != 'http'
      end

  end
end
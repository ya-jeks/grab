require 'open-uri'

module Grab
  class CollectionDownloader
    attr_accessor :collection

    def self.download!(coll, folder)
      cd = self.new coll
      cd.download folder
    end

    def initialize(list)
      @collection = list
    end

    def download(folder)
      prepare_dir folder
      collection.available.each do |res|
        t = Thread.new{ Grab::ResourceDownloader.download! res, folder }
        t.join
      end
    end

    protected
      def prepare_dir(folder)
        FileUtils.mkdir folder unless File.directory? folder
      end

  end
end
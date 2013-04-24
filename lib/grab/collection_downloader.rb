module Grab
  class CollectionDownloader
    attr_accessor :collection

    def initialize(list)
      @collection = list
    end

    def download_to(folder)
      collection.available.each do |res|
        rd = Grab::ResourceDownloader.new res
        rd.async.download_to folder
      end
    end

  end
end
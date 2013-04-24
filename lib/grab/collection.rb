module Grab
  class Collection
    attr_accessor :resources

    def initialize(urls)
      @resources = urls.map{|url| Grab::Resource.new url }
    end

    def available
      resources.select{|r| r.available? }
    end

    def completed
      resources.select{|r| r.completed? }
    end

    def downloading
      resources.select{|r| r.downloading? }
    end

    def broken
      resources.select{|r| r.broken? }
    end

  end
end
require 'celluloid'

module Grab
  class ResourceDownloader
    include Celluloid
    attr_reader :resource

    def initialize(res)
      @resource = res
    end

    def download_to(folder)
      resource.state = 'downloading'

      write_file :source => resource.url,
                 :file => resource.filename,
                 :folder => folder

      resource.state = 'completed'
      puts "Done: #{resource.url}\n"
    rescue => e
      resource.state = 'broken'
      puts "Error: #{e.message} - #{resource.url}\n"
    end

    protected
      def read_source(src_link)
        src = open src_link
        src.read
      end

      def write_file(opts)
        filepath = File.join opts[:folder], opts[:file]
        File.open(filepath, 'w') {|f| f.write read_source(opts[:source]) }
      end

  end
end
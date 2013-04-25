require 'benchmark'

module Grab
  class Manager
    attr_reader :folder, :links, :collection
    # TODO May be state_machine?

    def initialize(opts)
      @folder, @links = opts[:folder], opts[:links]
      @collection = Grab::Collection.new links
    end

    def start_download!
      prepare_folder! folder

      puts "Available images: #{collection.available.count}\n"

      time = Benchmark.realtime do
        downloader = Grab::CollectionDownloader.new collection
        downloader.download_to folder
      end

      wait_for_finish

      puts "Failed: #{collection.broken.count}\n"
      puts "Downloaded: #{collection.completed.count}\n"
      puts "Elapsed time: #{time} seconds\n"
    end

    protected
      def prepare_folder!(folder)
        FileUtils.mkdir folder unless File.directory? folder
      end

      def wait_for_finish
        loop { break if finished? }
      end

      def finished?
        collection.broken + collection.completed == collection.resources
      end

  end
end
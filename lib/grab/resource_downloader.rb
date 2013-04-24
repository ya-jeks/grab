module Grab
  class ResourceDownloader
    attr_reader :resource

    def self.download!(res, folder)
      rd = self.new res
      rd.download folder
    end

    def initialize(res)
      @resource = res
    end

    def download(folder)
      resource.state = 'downloading'

      write_file :src => open(resource.url),
                 :name => resource.filename,
                 :folder => folder

      resource.state = 'completed'
      puts "Done: #{resource.url}\n"
    rescue => e
      resource.state = 'broken'
      puts "Error: #{e.message} - #{resource.url}\n"
    end

    protected
      def write_file(opts)
        filepath = File.join opts[:folder], opts[:name]
        File.open(filepath, 'w+') {|f| f.write opts[:src].read }
      end

  end
end
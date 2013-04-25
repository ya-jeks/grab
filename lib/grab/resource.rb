require 'state_machine'

module Grab
  class Resource
    attr_reader :url

    state_machine :initial => :available do
      event :download do
        transition :available => :downloading
      end

      event :broke do
        transition :downloading => :broken
      end

      event :complete do
        transition :downloading => :completed
      end
    end

    def initialize(url)
      @url = url
      super()
    end

    def filename
      fname = File.basename url
      fname.split('?')[0]
    end

  end
end
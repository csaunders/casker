class BrochureController < ApplicationController
  helper_method :brochure
  def index
  end

  private
  def brochure
    @brochure ||= Brochure.new
  end

  class Brochure
    attr_reader :festivals, :pitch
    def initialize
      @festivals = Festival.where(name: 'Cask Days 2015')
      @pitch = Pitch.new.message
    end
  end

  class Pitch
    def message
      "Casker helps make you triage the overwhelming options available at Cask Days"
    end
  end
end

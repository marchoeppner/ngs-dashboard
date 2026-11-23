class PagesController < ApplicationController
  def dashboard
    @runs = Run.order(:created_at)
    @jobs = Job.all
    @instruments = Instrument.all
  end

  def settings
    @instruments = Instrument.order(:name)
  end
end

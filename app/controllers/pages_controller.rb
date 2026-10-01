class PagesController < ApplicationController
  def dashboard
    @runs = Run.order(:created_at)
    @jobs = Job.all
  end

  def settings
  end
end

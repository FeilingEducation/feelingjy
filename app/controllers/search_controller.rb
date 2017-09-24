class SearchController < ApplicationController

  def index
    @results = InstructorInfo.all
  end

end

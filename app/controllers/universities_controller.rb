class UniversitiesController < ApplicationController

  def index
    @universities = University.order("name_en")
  end

  def show
    @university = University.find(params[:id])
  end

end

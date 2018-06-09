class UniversitiesController < ApplicationController

  def index
    @universities = University.includes(:departments).order("name_en")
  end

  def show
    @university = University.find(params[:id])
  end

end

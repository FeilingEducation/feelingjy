class UniversitiesController < ApplicationController

  def index
    @universities = University.includes(:departments).order("name_en")
  end

  def show
    @university = University.friendly.find(params[:id])
  end

  def results
    # TODO implement search based on available data
    puts "========================="
    puts "Params:::#{params.inspect}"
    @universities = University.includes([:departments, :programs]).where("universities.id =? and degree ilike ?", params[:university], "%#{params[:degree]}%").references(:programs).order("universities.name_en")
    @universities = University.includes([:departments, :programs]).where("universities.id =?", params[:university]).references(:programs).order("universities.name_en") if @universities.empty?
    render :index
  end

end

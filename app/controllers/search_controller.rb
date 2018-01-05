class SearchController < ApplicationController

  def search
  end

  def confirmation
  end

  def terms
  end

  # TODO: better field design and searching queries
  def index
    @search = search_params
    @results = InstructorInfo.limit(3)
    unless @search[:min_rating].empty?
      @results = @results.where("avg_rating >= ?", @search[:min_rating])
    end
    unless @search[:join_at].empty?
      if @search[:join_at] == "半年内"
        @results = @results.where(created_at: 6.month.ago..Date.today())
      elsif @search[:join_at] == "半年到一年"
        @results = @results.where(created_at: 1.year.ago..6.month.ago)
      elsif @search[:join_at] == "一年以上"
        @results = @results.where('created_at < ?', 1.year.ago)
      end
    end
    unless @search[:price_range] == '0,1000'
      min, max = @search[:price_range].split(',')
      @results = @results.where(price_base: min..max)
    end
    unless @search[:service].empty?
      or_results = nil
      for service in @search[:service]
        if service == "早期咨询"
          tmp = @results.where(is_early_consult: true)
        elsif service == "头脑风暴"
          tmp = @results.where(is_brainstorm_consult: true)
        elsif service == "文书改写"
          tmp = @results.where(is_essay_consult: true)
        elsif service == "签证咨询"
          tmp = @results.where(is_visa_consult: true)
        end
        or_results = or_results.nil? ? tmp : or_results.or(tmp)
      end
      @results = or_results
    end
    unless @search[:available_time].empty?
    end
  end

  private

  def search_params
    defaults = {major: '', min_rating: '', join_at: '', price_range: '0,1000', service: [''], available_time: ['']}
    p = params.permit(:major, :min_rating, :join_at, :price_range, service: [], available_time: []).reverse_merge(defaults)
    p[:service].delete_at(0)
    p[:available_time].delete_at(0)
    p
  end

end

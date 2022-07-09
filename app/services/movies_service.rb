class MoviesService
  def self.get_url(url, keyword = nil)

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = ENV['movie_api_key']
      faraday.params[:query] = keyword if !keyword.nil?
    end

    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)

  end
  
  def self.get_top_rated
    get_url('3/movie/top_rated')[:results]
  end

  def self.find_movies(keyword)
    get_url("3/search/movie", keyword)[:results]
  end
end
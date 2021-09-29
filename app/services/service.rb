
class Service

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    data = response.body
    JSON.parse(data, symbolize_names:  true)
  end
  # def repo
  #   get_url("/repos/equinn125/little-esty-shop")
  # end
  #
  # def contributors
  #   get_url("/repos/equinn125/little-esty-shop/stats/contributors")
  # end
  #
  # def pull_requests
  #   get_url("/search/issues?q=repo:equinn125/little-esty-shop%20is:pull-request")
  # end
  #
  # def get_url(url)
  #   response = Faraday.get("https://api.github.com#{url}")
  #   JSON.parse(response.body, symoblize_names: true)
  # end
end

module Client::Logic

  def client_validated?(params)
    client = Client::Policy.find_by(app_id: params[:app_id]).client
    url = Client::Url.find_by(root_url: params[:request_url])
    client.urls.include?(url)
  end
end
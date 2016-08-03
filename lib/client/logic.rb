module Client::Logic

  def client_validated?(params)
    Client::Policy.find_by(app_id: params[:app_id]).client.present?
  end
end
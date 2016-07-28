class CampaignsController < ApplicationController
  def index
  end

  def show
    @campaign = Campaign.find(params[:id])
    render json: { "campaign": @campaign }
  end
end

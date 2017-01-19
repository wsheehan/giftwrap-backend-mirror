class Api::V1::CampaignsController < ApplicationController
  def index
  end

  def show
    @campaign = Campaign.where(client_id: @user_creds["client_id"], id: params[:id]).take
    render json: { "campaign": CampaignSerializer.new(@campaign) }, include: ['gifts.donor', 'donor_list']
  end
end

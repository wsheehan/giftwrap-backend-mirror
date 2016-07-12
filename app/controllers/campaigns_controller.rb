class CampaignsController < ApplicationController
  def index
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      # list = @campaign.donorlists.donors.each do |donor|
      #   #CampaignMailer.campaign_email(@campaign, donor).deliver_now
      # end
      render json: { "campaign": @campaign }
    else
      render json: { "errors": @campaign.errors }
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
    render json: { "campaign": @campaign }
  end

  def new
    @campaign = Campaign.new
    @donor_lists = DonorList.all
  end

  private

    def campaign_params
      params.require(:campaign).permit(:title, :body, :school_id, :user_id, donor_list_ids: [])
    end

end

class CampaignsController < ApplicationController
  def index
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      list = @campaign.donors.each do |donor|
        CampaignMailer.campaign_email(@campaign, donor).deliver_now
      end
    else
      render 'new'
    end
  end

  def show
  end

  def new
  end

  private

    def campaign_params
      params.require(:campaign).permit(:title, :school_id, :user_id, :donor_list_id)
    end

end

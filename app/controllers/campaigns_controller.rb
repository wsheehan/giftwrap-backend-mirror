class CampaignsController < ApplicationController
  def index
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      list = @campaign.donorlists.donors.each do |donor|
        #CampaignMailer.campaign_email(@campaign, donor).deliver_now
      end
    else
      render 'new'
    end
  end

  def show
  end

  def new
    @campaign = Campaign.new
    @donor_lists = DonorList.all
  end

  private

    def campaign_params
      params.require(:campaign).permit(:title, :school_id, :user_id, donor_list_ids: [])
    end

end

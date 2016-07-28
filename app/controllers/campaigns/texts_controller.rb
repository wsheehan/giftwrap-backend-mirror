class Campaigns::TextsController < ApplicationController
  def create
    if send_text
      create_campaign
    else
      render json: { "errors": { "msg": @text_error }}
    end
  end

  private

    def send_text
      begin
        @client = Twilio::REST::Client.new
        @client.messages.create(
          from: "+#{params[:text][:from]}",
          to: "+#{params[:text][:to]}",
          body: params[:text][:body]
        )
        true
      rescue Twilio::REST::RequestError => error
        @text_error = error.message
        false
      end
    end

    def create_campaign
      @campaign = Campaign.new(campaign_params)
      if @campaign.save
        save_text
      else
        render json: { "errors": @campaign }
      end
    end

    def save_text
      @text = @campaign.build_text(text_params)
      if @text.save
        render json: { "text": @text }
      else
        render json: { "errors": @text.errors }
      end
    end

    def text_params
      params.require(:text).permit(:to, :body, :from)
    end

    def campaign_params
      params.require(:campaign).permit(:user_id, :school_id, donor_list_ids: [])
    end
end

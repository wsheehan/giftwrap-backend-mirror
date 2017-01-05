class Api::V1::FormsController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @client = Client.find(params[:id])
    if @client.form.present?
      if params[:k].present?
        @donor = Donor.where(key: params[:k]).first
      end
      @conversion = create_conversion
      render json: { "form": { "id": @client.form.id, "client": @client, "donor": @donor, "metrics/forms/conversion": @conversion } }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private

    def create_conversion
      if @donor
        if params[:ca].present?
          @campaign_conversion = ::Metric::CampaignConversion.where(donor: @donor).where(campaign_id: params[:ca])[0]
        end
        @conversion = ::Metric::FormConversion.create(
          donor_id: @donor.id,
          metric_id: @client.metric.id,
          metric_campaign_conversions_id: @campaign_conversion
        )
      else
        @conversion = ::Metric::FormConversion.create(metric_id: @client.metric.id)
      end
      @conversion
    end

end

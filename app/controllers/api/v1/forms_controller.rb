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
          @conversion = ::Metric::FormConversion.create(donor_id: @donor.id, metric_id: @client.metric.id, campaign_id: params[:ca])
          ::Metric::CampaignConversion.where(donor: @donor).where(campaign_id: params[:ca]).update_attribute(:form_conversion, @conversion)
        else
          @conversion = ::Metric::FormConversion.create(donor_id: @donor.id, metric_id: @client.metric.id)
        end
      else
        @conversion = ::Metric::FormConversion.create(metric_id: @client.metric.id)
      end
    end

end

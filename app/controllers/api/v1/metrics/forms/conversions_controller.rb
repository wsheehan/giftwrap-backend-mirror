class Api::V1::Metrics::Forms::ConversionsController < ApplicationController

  def create
    @client = Client.find(conversion_params[:client_id])
    if params[:key]
      @donor = @client.donors.find_by_key conversion_params[:key]
      @conversion = ::Metric::FormConversion.create(donor: @donor, metric_id: @client.metric.id, campaign_id: conversion_params[:campaign_id])
      ::Metric::CampaignConversion.where(donor: @donor, campaign_id: conversion_params[:campaign_id]).form_conversion = @conversion
    else
      @conversion = ::Metric::FormConversion.create(metric_id: @client.metric.id)
    end
    render json: { "metrics/forms/conversion": @conversion }
  end

  def update
  end

  private

    def conversion_params
      params.require("metrics/forms/conversion").permit(:key, :client_id, :campaign_id)
    end

end

class Api::V1::Metrics::Forms::ConversionsController < ApplicationController
  def create
    conv = Conversion.create(hit_time: params[:hit_time], identifier: params[:identifier], school_id: params[:school_id])
    render json: conv.to_json
  end
end

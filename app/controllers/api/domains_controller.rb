class Api::DomainsController < ApplicationController
  private

  def resource
    @resource ||= Domains::FindByURL.new(URLSanitizer.call(params[:url]), URLValidator).call
  end

  def create_service
    Domains::Process
  end
end

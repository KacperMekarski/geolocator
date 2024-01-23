class Api::DomainsController < ApplicationController
  private

  def resource
    @resource ||= Domains::FindByURL.new(URLSanitizer.call(params[:url]), URLValidator).call
  end
end

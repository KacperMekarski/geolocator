class Api::DomainsController < ApplicationController
  private

  def resource
    @resource ||= Domains::FindByURL.new(URLSanitizer.call(params[:url]), URLValidator).call.tap do |domain|
      raise ActiveRecord::RecordNotFound unless domain.present?
    end
  end

  def resource_serializer
    ::DomainSerializer
  end

  def create_service
    Domains::Process
  end
end

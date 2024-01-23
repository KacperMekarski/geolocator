class Api::IPAddressesController < ApplicationController
  private

  def resource
    @resource ||= IPAddress.find_by!(address: params[:id])
  end

  def create_service
    IPAddresses::Process
  end
end

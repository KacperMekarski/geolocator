class Api::IPAddressesController < ApplicationController
  private

  def resource
    @resource ||= IPAddress.find_by!(address: params[:id])
  end
end

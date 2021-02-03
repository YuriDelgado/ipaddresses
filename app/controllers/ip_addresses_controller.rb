class IpAddressesController < ApplicationController
  def index
    @ips = params[:ips] || []
  end


  def validate
    redirect_to root_path(ips: process_ip_list)
  end

  private

  def ipaddresses_params
    params.permit(:ip_list)
  end

  def process_ip_list
    ipaddresses_params[:ip_list]
      .split(/,/)
      .map do |ip|
        ip.strip=~IPADDRESS_REGEX ? ip : INVALID_ADDRESS
    end
  end
end

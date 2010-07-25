require 'net/http'
require 'rexml/document'
include REXML


class MapsController < ApplicationController
  def index
  	@name = "City Eatouts"
  	@contact = "santosh.wadghule at gmail dot com"
  	@maplink = locateIp()
  end

  def locateIp
    if RAILS_ENV == "development"
  	  # ip = request.remote_ip;
  		# ips = ip.to_s;
  	  ips = "123.236.183.15"
    else
  	  #ips = "123.236.183.15";
  		ip = request.remote_ip
  		ips = ip.to_s
    end
  		
  		url = "http://ipinfodb.com/ip_query.php?ip="+ips+"&timezone=false"
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      xmldoc = REXML::Document.new(xml_data)

      # Now get the root element	
  		root = xmldoc.root
  		city = ""
  		regionName = ""
  		countryName = ""

  		# This will take country name...
  		xmldoc.elements.each("Response/CountryName") {
  		|e| countryName << e.text 
  	    }


  		# Now get city name...
  		xmldoc.elements.each("Response/City") {
     		|e| city << e.text 
  		}

  		# This will take regionName...
  		xmldoc.elements.each("Response/RegionName") {
     		|e| regionName << e.text 
  	    }
       ipLocation = city +", "+regionName+", "+countryName

  	 # stored city name in intance variable...
  	 @city = city
  	 return ipLocation
     end #end of method locateIp


  	def about
  	end

  	def share
  	end

  	def new
  	end

end

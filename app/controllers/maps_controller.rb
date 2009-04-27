require 'net/http'
require 'rexml/document'
include REXML


class MapsController < ApplicationController
	def index
	@name = "City Eatouts";
	@contact = "santosh.wadghule@gmail.com";
	@maplink = locateIp();
	
	
   end

	def locateIp
		
		ip = request.remote_ip;
		ips = ip.to_s;
		url = "http://iplocationtools.com/ip_query.php?ip="+ips;
		
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
=begin	
		def locateIp
		#!/usr/bin/env ruby -w

		ip = request.remote_ip;
        ipLocation = "http://iplocationtools.com/ip_query.php?ip=ip.to_s&output=xml"
		require 'net/http'
		require 'uri'

		uri = URI.parse('http://www.maxmind.com/app/locate_ip')
		res = Net::HTTP.post_form(uri,
  		{ 'ips' => ip.to_s,
    	  'type' => '', 'u' => '', 'p' => ''
   		} )
		fstr = res.body

		fstr.gsub!("Edition Results<\/span><p>","CHECKPOINT")
		fstr =~ /CHECKPOINT(.+?)<\/table>/m
		fields = $1.grep(/<(th|td)>/)
		fields.each do |f|
  		f.strip!
  		f.gsub!(/<[^>]+>/,"")
		end

		(0...13).each do |i|
  		puts ". #{fields[i]}: #{fields[i+13]}"
		end

		maplink = "http://maps.google.com/maps?q=#{fields[20]},+#{fields[21]}&iwloc=A&hl=en"
		#puts ". Google Maps URL: #{maplink}"
  		return maplink;
		end 
=end



end
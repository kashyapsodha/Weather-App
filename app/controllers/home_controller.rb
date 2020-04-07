class HomeController < ApplicationController
  def index
  	require 'net/http'
  	require 'json'
  	@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=94541&distance=0&API_KEY=FBD60089-6B96-406D-8655-0D22B47B7A95'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)
  	if @output.empty?
  		@final_output = "Invalid value"
  		@location = "Invalid location"
  	elsif !@output
  		@final_output = "Invalid value"
  		@location = "Invalid location"
  	else
  		@final_output = @output[0]['AQI']
  		@location = @output[0]['ReportingArea'] + ", " + @output[0]['StateCode']
  	end

  	if @final_output == "Invalid value"
  		@api_color = "silver"
  	elsif @final_output <= 50
  		@api_color = "green"
  	elsif @final_output >= 51 && @final_output <= 100
  		@api_color = "yellow"
  	elsif @final_output >= 101 && @final_output <= 150
  		@api_color = "orange"
  	elsif @final_output >= 151 && @final_output <= 200
  		@api_color = "red"
  	elsif @final_output >= 201 && @final_output <= 300
  		@api_color = "purple"
  	elsif @final_output >= 301 && @final_output <= 500
  		@api_color = "maroon"
  	end
  end
end

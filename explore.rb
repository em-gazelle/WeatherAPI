#require 'bundler/setup'
require 'rubygems'
require 'sinatra'
#api - weather data
require 'open-uri'
require 'json'
require 'shotgun'
require 'haml'
require 'sinatra/graph'

get '/' do
	def say
		"This is my first app in Ruby!"
	end	
	haml :index, :locals => {:say => say}
end


graph "YesterdaySF", :prefix => '/graphs' do

	open('http://api.wunderground.com/api/245e798812323642/yesterday/q/CA/San_Francisco.json') do |f| 
				json_string = f.read 
				parsed_json = JSON.parse(json_string) 
				#display for every hour
				#creating hashes
				hourHumidity = Hash.new
				#parsing json for API's data on humidity over past 24 hours:
				for hourNum in 0...25
					#pretty = parsed_json['history']['observations'][hourNum]['date']['pretty']
					#for x-axis
					hour = parsed_json['history']['observations'][hourNum]['date']['hour']
					#min = parsed_json['history']['observations'][hourNum]['date']['min']
					#for y-axis
					hum = parsed_json['history']['observations'][hourNum]['hum']
					#rain = parsed_json['history']['observations'][hourNum]['rain']
					#adding each variable to the array:
					
					hourN = hour.to_i
					humN = hum.to_i
				
					hourHumidity[hourN] = humN
				end
				#hourHumidity.each { |x, y| puts "#{x}: #{y}" }

					#buys = [4, 2, 1, 4, 5]
				#	sales = [5,2,6,2,1]

				#	experiment = { 1=>2, 6=>5, 3=>7, 4=>2, 5=>1}

				line "Humidity Percentage", hourHumidity
				#line "Buys", experiment
				#line "Sales", sales
				#hourHumidity
		end
end
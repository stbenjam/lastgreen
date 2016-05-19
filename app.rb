require 'sinatra'
require 'net/http'
require 'json'
require 'pry'
require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

get '/' do
  release_job = JSON.load(Net::HTTP.get(URI.parse('http://ci.theforeman.org/view/Katello%20Pipeline/job/release_push_rpm_katello/api/json')))
  last_build = release_job['lastBuild']['number']
  last_success_date = time_ago_in_words(Time.at(JSON.load(Net::HTTP.get(URI.parse("http://ci.theforeman.org/view/Katello%20Pipeline/job/release_push_rpm_katello/#{last_build}/api/json")))['timestamp']/1000))

  "<html><body><h1 style='align: center; position: absolute; top: 50%; left: 50%; transform: translateX(-50%) translateY(-50%);'>#{last_success_date} since last green build</h1></body></html>"
end

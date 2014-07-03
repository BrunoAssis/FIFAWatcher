# coding: utf-8
require 'curb'
require 'json'
require 'pry'

curl_service = Curl::Easy.new("https://fwctickets.fifa.com/TopsAkaCalls/Calls.aspx/getBasicData?l=en&c=BRA") do |curl|
	curl.headers["User-Agent"] = "Chrome/35.0.1916.153"
end

begin
  while (true)
    curl_service.perform

    json_response = JSON.parse(curl_service.body_str)
    json_response = JSON.parse(json_response["d"]["data"])

    products = json_response["BasicCodes"]["PRODUCTPRICES"]
    products = products.select{|p| p["PRPProductId"] == "IMT62" && p["Quantity"].to_i > 1}

    if products.size > 0
      puts "Tem! Enviando tweet!"

      `t update "@BrunoAssis @KarenKoritiak o devorador de mundos acordou as #{Time.now.to_s}"`
    else
      puts "Não tem :("
    end

    sleep 20.0
  end
rescue
  `t update "@BrunoAssis @KarenKoritiak às #{Time.now.to_s}, um super vilão apareceu."`
end
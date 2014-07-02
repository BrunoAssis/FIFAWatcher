# coding: utf-8
require 'curb'
require 'json'
require 'pry'

# require 'mail'
# require 'encryptor'

# Mail.defaults do
#   delivery_method :smtp, {  :address              => "smtp.gmail.com",
#                             :port                 => 587,
#                             :domain               => 'brilhe.me',
#                             :user_name            => 'bruno@brilhe.me',
#                             :password             => "\x9E\x94~\xF1\xA4\xB2\xBD6>\x87\xA4\x82\xFD\x8C\x04\x12".decrypt(key: "Hiauhhoiusdhfisoufh98hwfh8hf8HF3"),
#                             :authentication       => 'plain',
#                             :enable_starttls_auto => true  }
# end

curl_service = Curl::Easy.new("https://fwctickets.fifa.com/TopsAkaCalls/Calls.aspx/getBasicData?l=en&c=BRA") do |curl|
	curl.headers["User-Agent"] = "Chrome/35.0.1916.153"
end

while (true)
  curl_service.perform

  json_response = JSON.parse(curl_service.body_str)
  json_response = JSON.parse(json_response["d"]["data"])

  products = json_response["BasicCodes"]["PRODUCTPRICES"]
  products = products.select{|p| p["PRPProductId"] == "IMT62" && p["Quantity"].to_i > 1}

  if products.size == 0
    puts "Tem! Enviando e-mail."

    `t update "@BrunoAssis @KarenKoritiak Testando3`

    #Mail.deliver do
    #  to 'brunoassis@gmail.com, karen.koritiak@gmail.com'
    #  from 'bruno@brilhe.me'
    #  subject 'TEM INGRESSOS! CORRE!'
    #  body 'Run, Forrest, Run!'
    #end
  else
    puts "Não tem :("
  end

  sleep 20.0
end
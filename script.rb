require 'httparty'
require 'byebug'

USER_ID = "4193409"

HEADERS = {
  "Harvest-Account-ID": "1588227",
  "Authorization": "Bearer 1704398.pt.dvMovVDUBawFLm1YsbyRHJCbvhSupq5JkBpc7QUcXdOb6_slEeHU9HfNwO2v8kkdMEEW2RldjyfGEDjpiQBI2A",
  "User-Agent": "Harvest API Example"
}

# response = HTTParty.get("https://api.harvestapp.com/api/v2/users/me.json",
#   headers: HEADERS,
#   body: { }
# )
response = HTTParty.get("https://api.harvestapp.com/v2/users/me/project_assignments",
  headers: HEADERS,
  body: { }
)



pp response

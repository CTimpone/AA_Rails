require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
    query_values: {
      'user[name]' => 'Bart', # YOUR API KEY HERE
      'user[email]' => "bart@simpson.com",
    }
  ).to_s

  p url
end

create_user

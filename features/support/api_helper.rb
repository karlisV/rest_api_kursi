require 'rest-client'

def post(url, headers: {}, cookies: {}, payload: {})
  RestClient::Request.execute(
    method: :post,
    url: url,
    headers: headers,
    cookies: cookies,
    payload: payload
  ) do |response|
    response
  end
end

def get(url, headers: {}, cookies: {})
  RestClient::Request.execute(
    method: :get,
    url: url,
    headers: headers,
    cookies: cookies
  ) do |response|
    response
  end
end

def put(url, headers: {}, cookies: {}, payload: {})
  RestClient::Request.execute(
    method: :put,
    url: url,
    headers: headers,
    cookies: cookies,
    payload: payload
  ) do |response|
    response
  end
end

def delete(url, headers: {}, cookies: {})
  RestClient::Request.execute(
    method: :delete,
    url: url,
    headers: headers,
    cookies: cookies
  ) do |response|
    response
  end
end

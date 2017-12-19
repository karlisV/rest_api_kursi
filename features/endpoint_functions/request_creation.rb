def create_collection
  new_collection_payload = { name: 'TESTAPI',
                             description: '' }.to_json
  response = post('https://www.apimation.com/collections',
                  headers: { 'ContentType' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: new_collection_payload)
  # check if 200 OK is received
  assert_equal(200, response.code, "Collection was not created! Response: #{response}")
  response_hash = JSON.parse(response)
  assert_equal('TESTAPI', response_hash['name'], 'Wrong collection name')
  assert_not_equal(nil, response_hash['id'], 'Collection ID is empty')
end

def fetch_created_collection_id
  response = get('https://www.apimation.com/collections',
                 headers: {},
                 cookies: @test_user.session_cookie)
  # check if 200 OK is received
  assert_equal(200, response.code, "Failed to get collections! Response: #{response}")
  response_hash = JSON.parse(response)
  collection_id = nil
  collection_found = false
  # search for a project
  response_hash.each do |collection|
    next unless collection['name'].to_s == 'TESTAPI'
    collection_id = collection['id'].to_s
    collection_found = true
  end
  assert_equal(true, collection_found, 'Collection ID was not found')
  collection_id
end

def fetch_all_collection_ids
  response = get('https://www.apimation.com/collections',
                 headers: {},
                 cookies: @test_user.session_cookie)
  # check if 200 OK is received
  assert_equal(200, response.code, "Failed to get collections! Response: #{response}")
  response_hash = JSON.parse(response)
  collection_ids = []
  response_hash.each do |collection|
    collection_ids.push(collection['id']) unless collection['id'].empty?
  end
  collection_ids
end

def delete_all_collections(collection_ids)
  collection_ids.each do |collection|
    response = delete("https://www.apimation.com/collections/#{collection}",
                      headers: {},
                      cookies: @test_user.session_cookie)
    # check if response is correct
    assert_equal(204, response.code, "Could not delete collection! Response: #{response}")
  end
end

def create_request(collection_id, request_name)
  request_payload = { collection_id: collection_id,
                      name: request_name + @session_id,
                      request: { method: 'POST',
                                 type: 'raw',
                                 url: 'http://apimation.com/login',
                                 body: "{\"login\": \"#{@test_user.email}\",
 \"password\": \"#{@test_user.password}\"}" } }.to_json
  request_payload
end

def save_request_to_collection(request_payload)
  response = post('https://www.apimation.com/steps',
                  headers: { 'ContentType' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: request_payload)
  assert_equal(200, response.code, "Request was not created! Response: #{response}")
end

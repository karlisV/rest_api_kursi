Then(/^I create a request collection$/) do
  create_collection
end

Then(/^I create a "([^"]*)" request and save it to the collection$/) do |request_name|
  collection_id = fetch_created_collection_id
  request_payload = create_request(collection_id, request_name)
  save_request_to_collection(request_payload)
end

And(/^I delete all collections$/) do
  collection_ids = fetch_all_collection_ids
  delete_all_collections(collection_ids)
end
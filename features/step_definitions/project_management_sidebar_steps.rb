When(/^I create a project$/) do
  create_project
end

And(/^I create these environments:$/) do |environments|
  # table is a table.hashes.keys # => [:Environment]
  set_project_as_active
  environments = environments.hashes
  environments.each do |environment|
    environment_name = environment['Environment name']
    puts environment_name
    create_env(environment_name)
  end
end

And(/^I create global variables for "([^"]*)" environment:$/) do |environment, global_variables|
  # table is a table.hashes.keys # => [:key, :value]
  global_variables_hash = global_variables.hashes
  environment_id = fetch_env_id(environment)
  create_global_vars(environment_id, global_variables_hash)
end

Then(/^I check if these variables are created for "([^"]*)" environment:$/) do |environment, global_variables|
  global_variables_hash = global_variables.hashes
  environment_id = fetch_env_id(environment)
  check_global_vars(environment_id, global_variables_hash)
end

And(/^I delete all environments$/) do
  environment_ids = fetch_all_env_ids
  delete_all_env_ids(environment_ids)
end

And(/^I check that no environment is in the project$/) do
  environment_ids = fetch_all_env_ids
  assert_true(environment_ids.empty?)
end
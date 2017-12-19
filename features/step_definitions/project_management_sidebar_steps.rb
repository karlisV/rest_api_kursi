When(/^I create a project$/) do
  create_project
end

And(/^I create these environments:$/) do |environments|
  # table is a table.hashes.keys # => [:Environment]
  project_id = fetch_created_project_id
  set_project_as_active(project_id)
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

And(/^I select an existing project$/) do
  all_project_ids = fetch_all_project_ids
  if all_project_ids.empty?
    create_project
    project_id = fetch_created_project_id
  else
    project_id = all_project_ids[0]
  end
  set_project_as_active(project_id)
end
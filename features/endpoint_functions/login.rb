require 'rest-client'
require 'test-unit'

def login_positive
  login_payload = { login: @test_user.email,
                    password: @test_user.password }.to_json
  response = post('https://www.apimation.com/login',
                  headers: { 'ContentType' => 'application/json' },
                  cookies: {},
                  payload: login_payload)
  # check if 200 OK is received
  assert_equal(200, response.code, "Login failed! Response: #{response}")
  response_hash = JSON.parse(response)
  assert_equal(@test_user.email, response_hash['email'],
               'E-mail in the response is not correct')
  assert_not_equal(nil, response_hash['user_id'], 'User ID is empty')
  assert_equal(@test_user.email, response_hash['login'],
               'Login in the response is not correct')

  @test_user.set_session_cookie(response.cookies)
  @test_user.set_user_id(response_hash['user_id'])
end

def check_personal_info
  response = get('http://apimation.com/user',
                 headers: {},
                 cookies: @test_user.session_cookie)
  # check if 200 OK is received
  assert_equal(200, response.code, "Failed to fetch user data! Response: #{response}")
  response_hash = JSON.parse(response)
  assert_equal(@test_user.email, response_hash['email'],
               'E-mail in the response is not correct')
  assert_equal(@test_user.email, response_hash['login'],
               'Login in the response is not correct')
end

def login_wrong_password
  login_payload = { login: @test_user.email,
                    password: 'nepareizaParole' }.to_json
  response = post('https://www.apimation.com/login',
                  headers: { 'ContentType' => 'application/json' },
                  cookies: {},
                  payload: login_payload)
  # check if 200 OK is received
  assert_equal(400, response.code, "Wrong error code received! Response: #{response}")
  response_hash = JSON.parse(response)
  assert_equal('002', response_hash['error-code'], 'Error code response is not correct')
  assert_equal('Username or password is not correct', response_hash['error-msg'], 'Wrong error message is displayed')
  @test_user.set_session_cookie(response.cookies)
end

def check_user_not_logged_in
  response = get('http://apimation.com/user',
                 headers: {},
                 cookies: @test_user.session_cookie)
  assert_equal(400, response.code, "Wrong error code received! Response: #{response}")
  response_hash = JSON.parse(response)
  assert_equal('001', response_hash['error-code'], 'Error code response is not correct')
  assert_equal('No session', response_hash['error-msg'], 'Wrong error message is displayed')
end
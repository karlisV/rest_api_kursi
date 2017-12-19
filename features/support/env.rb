Before() do
  @test_user = User.new('karlis.test1@yopmail.com', 'parole123')
  @session_id = set_session_id
end

After() do
  puts "this happens after a test"
end
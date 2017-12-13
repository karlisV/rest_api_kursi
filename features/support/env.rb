Before() do
  @test_user = User.new('karlis.test@yopmail.com', 'parole123')
end

After() do
  puts "this happens after a test"
end
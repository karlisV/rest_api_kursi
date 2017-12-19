# Create session id based on time of execution
def set_session_id
  time = Time.new
  time.strftime('%H%M%S')
end
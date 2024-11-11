every :day, at: '12:00am' do
  runner "PollResultsSender.send_results"
end

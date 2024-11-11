class PollResultsSender
  def self.send_results
    Poll.all.each do |poll|
      results = poll.options.map { |option| [option.content, option.votes.count] }.to_h
      PollMailer.send_poll_results(poll, results).deliver_now
    end
  end
end

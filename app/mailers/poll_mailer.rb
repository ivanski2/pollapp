class PollMailer < ApplicationMailer
  default from: 'ivanski34@gmail.com'

  def send_poll_results(poll, results)
    @poll = poll
    @results = results
    mail(to: '360vu.eu@gmail.com', subject: "Results for #{poll.question}")
  end
end

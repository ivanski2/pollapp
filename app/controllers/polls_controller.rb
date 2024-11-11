class PollsController < ApplicationController
  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find(params[:id])
    @options = @poll.options
  end

  def vote
    @poll = Poll.find(params[:id])
    option = @poll.options.find(params[:option_id])
    user_identifier = "#{request.remote_ip}_#{session.id}"

    unless Vote.exists?(poll_id: @poll.id, user_identifier: user_identifier)
      option.increment!(:vote_count)
      Vote.create(poll_id: @poll.id, option_id: option.id, user_identifier: user_identifier)

      respond_to do |format|
        format.html { redirect_to poll_path(@poll), notice: 'Thanks for voting!' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to poll_path(@poll), alert: 'You have already voted in this poll.' }
        format.js
      end
    end
  end

  private

  def poll_params
    params.require(:poll).permit(:question)
  end
end

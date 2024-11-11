module Admin
  class PollsController < ApplicationController
    before_action :require_admin
    before_action :set_poll, only: [:show, :edit, :update, :destroy, :toggle_status, :duplicate]

    def index
      @polls = Poll.all
    end

    def show
      @poll = Poll.find(params[:id])
      @options = @poll.options

      @chart_data = @options.map { |option| { label: option.content, count: option.vote_count || 0 } }
    end

    def new
      @poll = Poll.new
      @poll.options.build
    end

    def create
      @poll = Poll.new(poll_params)

      if @poll.save
        redirect_to admin_polls_path, notice: "Poll created successfully."
      else
        render :new
      end
    end

    def edit; end

    def update
      @poll = Poll.find(params[:id])
      if @poll.update(poll_params)
        redirect_to @poll, notice: 'Poll was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @poll.destroy
      redirect_to admin_polls_path, notice: "Poll deleted successfully."
    end

    def toggle_status
      @poll.update(active: !@poll.active)
      redirect_to admin_polls_path, notice: "Poll status updated."
    end

    def duplicate
      @original_poll = Poll.find(params[:id])
      @duplicate_poll = @original_poll.dup
      @duplicate_poll.question += " (Duplicate)"

      @original_poll.options.each do |option|
        @duplicate_poll.options.build(content: option.content)
      end

      if @duplicate_poll.save
        redirect_to admin_polls_path, notice: 'Poll was successfully duplicated.'
      else
        redirect_to admin_polls_path, alert: 'Failed to duplicate the poll.'
      end
    end

    private

    def require_admin
      unless session[:admin_id]
        puts "No admin_id in session"
        redirect_to admin_login_path, alert: "You must be logged in to access this section"
      end
    end

    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:question, options_attributes: [:id, :content, :_destroy])
    end

  end
end

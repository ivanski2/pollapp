module Admin
  class PollsController < ApplicationController
    before_action :set_poll, only: [:show, :edit, :update, :destroy, :toggle_status, :duplicate]
    before_action :check_admin_rights

    def index
      @grid = PollsGrid.new(params[:polls_grid]) do |scope|
        scope.page(params[:page])
      end
    end

    def show
      @chart_data = @poll.options.map do |option|
        { label: option.content, count: option.vote_count || 0 }
      end
    end

    def new
      @poll = Poll.new
      3.times { @poll.options.build }
    end

    def create
      @poll = Poll.new(poll_params)
      if @poll.save
        redirect_to admin_polls_path, notice: "Poll created successfully."
      else
        render :new
      end
    end

    def update
      if @poll.update(poll_params)
        redirect_to admin_poll_path(@poll), notice: 'Poll was successfully updated.'
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
      duplicate_poll = duplicate_poll_with_options
      if duplicate_poll.save
        redirect_to admin_polls_path, notice: 'Poll was successfully duplicated.'
      else
        redirect_to admin_polls_path, alert: 'Failed to duplicate the poll.'
      end
    end

    private

    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      params.require(:poll).permit(:question, options_attributes: [:id, :content, :_destroy])
    end

    def duplicate_poll_with_options
      original_poll = Poll.find(params[:id])
      duplicate_poll = original_poll.dup
      duplicate_poll.question += " (Duplicate)"
      original_poll.options.each do |option|
        duplicate_poll.options.build(content: option.content)
      end
      duplicate_poll
    end

    private

    def check_admin_rights
      if current_user.nil? || !current_user.admin?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end
end

class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.create_entry(entry_params)

    if @entry.valid?
      redirect_to entry_path(@entry)
    else
      flash.now[:error] = @entry.errors.full_messages
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  private

  def entry_params
    params.
      require(:entry).
      permit(:date, goals: []).
      merge(user: current_user)
  end
end

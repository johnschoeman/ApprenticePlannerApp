class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.build_entry(entry_params)

    if @entry.valid?
      @entry.save
      redirect_to entry_path(@entry)
    else
      flash[:errors] = @entry.errors.full_messages
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

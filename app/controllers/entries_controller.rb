class EntriesController < ApplicationController
  def new
    @entry_form = EntryForm.new
  end

  def create
    @entry_form = EntryForm.new(entry_form_params)

    if @entry_form.save
      redirect_to entry_path(@entry_form.entry)
    else
      flash.now[:error] = @entry_form.errors.full_messages
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  private

  def entry_form_params
    params.
      require(:entry_form).
      permit(:date, goal_descriptions: []).
      merge(user: current_user).
      to_h.
      symbolize_keys
  end
end

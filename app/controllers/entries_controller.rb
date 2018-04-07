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

  def index
    @entries = Entry.all
  end

  def edit
    @entry_form = EntryForm.find_by_entry_id(params[:id])
  end

  def update
    @entry_form = EntryForm.find_by_entry_id(params[:id])

    if @entry_form.update_attributes(entry_form_params)
      redirect_to entry_path(@entry_form.entry)
    else
      flash.now[:error] = @entry_form.errors.full_messages
      render :edit
    end
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

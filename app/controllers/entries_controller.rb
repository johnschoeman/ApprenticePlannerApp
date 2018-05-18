class EntriesController < ApplicationController
  def new
    @entry_form = EntryForm.new
  end

  def create
    @entry_form = EntryForm.new

    if @entry_form.update_attributes(entry_form_params)
      flash[:success] = "Entry has been created"
      redirect_to entry_path(@entry_form.entry)
    else
      flash.now[:error] = @entry_form.errors.full_messages
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
    @goals = @entry.goals.with_descriptions
    @note = @entry.note
  end

  def index
    @entries = Entry.all
    @tidbit = TidbitGenerator.generate
  end

  def edit
    entry = Entry.includes(:goals).find(params[:id])
    @entry_form = EntryForm.new(entry: entry)
  end

  def update
    entry = Entry.includes(:goals).find(params[:id])
    @entry_form = EntryForm.new(entry: entry)

    if @entry_form.update_attributes(entry_form_params)
      flash[:success] = "Entry has been updated"
      redirect_to entry_path(@entry_form.entry)
    else
      flash.now[:error] = @entry_form.errors.full_messages
      render :edit
    end
  end

  def destroy
    entry = current_user.entries.find_by(id: params[:id])
    if entry.present?
      entry.destroy
      flash[:success] = "Entry has been deleted"
    else
      flash[:error] = "You are not authorized to delete this entry"
    end
    redirect_to entries_path
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

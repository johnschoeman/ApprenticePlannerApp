class NotesController < ApplicationController
  before_action :require_entry_to_belong_to_user

  def create
    @entry = entry
    note = Note.new(content: note_params[:content], entry: @entry)
    persist_note_and_redirect(note: note, entry: @entry, params: note_params)
  end

  def update
    @entry = entry
    note = @entry.note
    persist_note_and_redirect(note: note, entry: @entry, params: note_params)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

  def require_entry_to_belong_to_user
    unless entry.user == current_user
      flash[:error] = "Entry does not belong to you"
      redirect_to entries_path
    end
  end

  def persist_note_and_redirect(note:, entry:, params:)
    if note.update_attributes(params)
      flash[:success] = "Note Saved"
    else
      flash[:error] = note.errors.full_messages
    end
    redirect_to entry_path(entry)
  end

  def entry
    @_entry_for_notes ||= Entry.find(params[:entry_id])
  end
end

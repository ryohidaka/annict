# frozen_string_literal: true

class TrackableAnimeController < V4::ApplicationController
  before_action :authenticate_user!

  def show
    @anime = Work.only_kept.find(params[:anime_id])
    @library_entry = current_user.library_entries.find_by!(work: @anime)
    @episodes = @anime.
      episodes.
      only_kept.
      where.not(id: @library_entry.watched_episode_ids).
      order(sort_number: :desc).
      page(params[:page]).
      per(10)
  end
end

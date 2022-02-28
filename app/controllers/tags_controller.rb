class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: %i[ show edit update destroy ]

  # GET /tags or /tags.json
  def index
    @tags = current_user.tags.uniq
  end

  # GET /tags/1 or /tags/1.json
  def show
    @images = @tag.images.query(params[:query]).includes(:tags)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = current_user.tags.find(params[:id])
    end
end

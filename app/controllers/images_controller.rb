class ImagesController < ApplicationController
  before_action :set_tags, :set_images, only: [:index]
  before_action :set_image, only: %i[ show edit update destroy ]

  # GET /images or /images.json
  def index
    @pagy, @images = pagy(@images)
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = current_user.images.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = current_user.images.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = current_user.images.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:name, :file, :description)
    end

    def set_images
      @all_images = @images = current_user.images.includes(:tags)
      @all_images = @images = @images.query_by_name(params[:name]) if params[:name].present?
      @images = @images.filter_by_tag(params[:tag_id]) if params[:tag_id].present?
      @images = name_sortable(@images)
    end

    def set_tags
      # we just want the tags with images
      @tags = Tag.includes(:image_tags).where.not(image_tags: { image_id: nil })
      @tags = @tags.includes(:images).where('images.name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
    end
end

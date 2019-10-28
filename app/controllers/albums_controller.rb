class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_albums
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    respond_to do |format|
      format.html { render partial: 'albums/album' }
      format.json { render :show, status: :ok, location: @album }
    end
  end

  # GET /albums/new
  def new
    @album = Album.new
    render partial: 'form'
  end

  # GET /albums/1/edit
  def edit
    render partial: 'form'
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = current_user.albums.build(album_params)
    respond_to do |format|
      if @album.save
        flash.now[:notice] = 'Album was successfully created.'
        format.html { render partial: 'index' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render partial: 'form', status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        flash.now[:notice] = 'Album was successfully updated.'
        format.html { render partial: 'index' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render partial: 'form', status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      flash.now[:alert] = 'Album was successfully destroyed.'
      format.html { render partial: 'index' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_albums
      @albums = Album.all
    end

    def set_album
      @album = @albums.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :user_id, :content)
    end
end

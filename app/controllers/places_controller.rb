class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    #@places = Place.all
    @place = Place.new
  end

  # GET /places/1
  # GET /places/1.json
  def show
    begin
        @place = Place.find(params[:id])
        @client = GooglePlaces::Client.new('AIzaSyC-spk1vTbKfmy1Ak7fdlbzLdShy_7i0O0')

        @caffee_list = @client.spots_by_query("coffee near #{@place .city} #{@place.state}" )
    rescue

        flash[:notice] = "We could not perform a search at this time. Please try again :)"
        redirect_to new_place_path
   end
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
        @place = Place.create(
        :city => params[:place][:city],
        :state  => params[:place][:state]
       )
      @var  = params[:place][:city]
      if @place.save
         redirect_to @place

      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params[:place]
    end
end

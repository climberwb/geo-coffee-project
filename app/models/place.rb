class Place < ActiveRecord::Base
  def google_place_query
    @place = Place.find(params[:id])
    @client = GooglePlaces::Client.new('AIzaSyC-spk1vTbKfmy1Ak7fdlbzLdShy_7i0O0')

    @caffee_list = @client.spots_by_query("coffee near #{@place .city} #{@place.state}" )
  end
end

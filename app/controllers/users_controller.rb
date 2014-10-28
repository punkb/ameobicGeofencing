class UsersController < ApplicationController
#  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

#Event Data Starts
    @events = Event.all
    @event_Titles = Array.new
    @event_Coord = Array.new
    @events.each do |e|
      @event_Titles << e.title
      @event_Coord << e.eventcoordinates 
    end
    @eventTitle = @event_Titles[0] #@eventTitle = TestingEvent
    @eventCoords = @event_Coord[0] #@eventCoords = [-6.22998, 53.3516]
#EventData Ends

    @places = Place.all
    @users = User.all

    @present = Array.new
    @boundary = Array.new

    @neighbours_array = Array.new

    
     def event_neighbour(coords) 
      if coords == nil
        coords = @eventCoords
      end
      @center_coordinate = coords
      @temp = Array.new
      @resultCoord

    @data = Place.geo_near(@center_coordinate).spherical.max_distance(0.00001)

    # @data.each do |d|
    #   @neighbours_array << d._id 
    #   @temp = d.location.coordinates
    # end
    @neighbours_array = @data.map{|d| d._id}
    @temp = @data.map {|d| d.location.coordinates}
     puts "*******@temp***"
  puts @temp

    
      #search_neighbour(@temp)
  

  
    return @neighbours_array, @temp
  end

  
event_neighbour(@eventCoords)

puts "*******@temp***"
  puts @temp





def search_neighbours(c, d)



  @queryData = Place.geo_near(c).spherical.max_distance(d)


  puts "****@queryData******"
  puts @queryData.map { |e| e._id }

  if @queryData.nil?
     @queryData = Place.geo_near(c).spherical.max_distance(1)
   end


@neighbours_data = @queryData


  @neighbours_array = @neighbours_data.map{|d| d._id}
  @neighbours_cordinates = @neighbours_data.map {|d| d.location.coordinates}
  puts "****@neighbours_cordinates******"
  puts @neighbours_cordinates
  puts "******************************"
  @present = @neighbours_cordinates

# return @present, @neighbours_cordinates, @neighbours_array

  
end
@d = 0.00001
search_neighbours(@temp[0], @d)



  @pre = @present.map { |n| search_neighbours(n, @d) }.uniq 



  #@pre = @present.map { |n| search_neighbours(n, @d) }
    
 

  puts "**********"
  puts @queryData.map { |e| e._id }


#search_neighbour(@temp)

    # def push_neighbours(neighbours_array)

    #   @temp = Array.new
    #   @n = neighbours_array
    #   limit = neighbours_array.length

    #   for i in 0..limit
    #     for k in 0..@detected_array.length
    #       if (@n[i] != @detected_array[k])
    #         @temp << @n[i]
    #         @detected_array << @n[i]
    #         else
    #         break  
    #     end
    #   end
    #   return @temp
      
    # end



    #@neighbours = Array.new

    #  @Avgnear = Location.geo_near(@eventCoords).distance_multiplier(5012)
    # @near = Place.geo_near([0, 0]]).spherical

    # @near.each do |n|
    #   u = n.user_id
    #   @n = User.where({_id: u })
    #   @neighbours << @n.name
    # end




    # @data = Place.where({location:{type: "Point"}})

    # @data.each do |d|
    #   @userID = d.user_id
    # end
    # @user = User.where(_id: @userID)
    # #@data = User.where(name: "Pankaj")


  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end

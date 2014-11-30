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

    #Variables
    @places = Place.all
    @users = User.all
    
    @present = Array.new  #Array of In-Boundary users/InStadium Users
    @boundary = Array.new  #Array of Boundary User (The main output array)
    @neighbours_array = Array.new
    @presentFinal = Array.new

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
    
    def first_user(coords) 
      @temp = Array.new
      @data = Place.geo_near(coords).spherical.max_distance(0.00001)

        @neighbours_array = @data.map{ |d| d._id }
        @temp = @data.map { |d| d.location.coordinates }

        puts "******@tempInside"
        puts @temp
        puts @temp.length
        
        
        @temp.map { |e| @t = e  }
        #@present << @t

    puts "*******@presentLength***"
    puts @present.length

    puts "*******@tLength***"
    puts @t.length

    puts "*******@tempLength***"
    puts @temp.length

    #return @neighbours_array, @temp
    end
    
    first_user(@eventCoords)


    @distance = 0.00001

    @neighbours_cordinates = Array.new

    @present << @temp

    #making 3d (@presentArray [[[x,y]]]) tp 2d@present [[]] array to comapre
     @present.each do |x|
      x.each do |y|
        @presentFinal << y
      end
    end


def search_rec(dist, coordinates)

  unless @present.length == 8

@nextData = Array.new()
for i in 1..coordinates.length

    localTemp = Array.new()
    @p = Array.new 
    @uniqArray = Array.new 


    puts "******localTemp0****"
    puts @localTemp

    #@localTemp << coordinates

    coordinates.map { |x| @q = x }

    puts "*****@q***"
    puts @q

    @queryData = Place.geo_near(@q).spherical.max_distance(dist)
    b = @queryData


    #extract the location.coordinates from @queryData and put it in @uniqArray(2D array of coordinates) 
    @queryData.map { |x| @uniqArray << x.location.coordinates }
   

    #Extracting Uniq coordinates by comaparing presentFinal data with new data 
   @uniqArray = @uniqArray-@presentFinal

   if @uniqArray.empty?

    @boundary = coordinates

    puts"***Array is Empty****"
    @distance = 0.00002

     

  else

   #map uniq array to presentFinal 2D Array 
   @uniqArray.map { |e| @presentFinal << e  }
 end

   @queryData.map { |x| localTemp = x.location.coordinates }     


    #Push each set of coordinates from @localTemp to @present
    # @localTemp.map { |x| @present << x  }
    @presentTemp = @queryData.map { |x| x.location.coordinates }.uniq
    

    @present << @presentTemp.map { |x| x }
   

    #@present << @queryData.map { |x| x.location.coordinates }.uniq

     


    #push each set of coordinates from @localTemp to @nextData for next iteration after this for loop
    #@localTemp.map { |x| @nextData << x  }
    @nextData << localTemp

    puts "*******@nextData"
    puts @nextData 


  search_rec(@distance, @nextData)
  end
 
  end

end
search_rec(@distance, @temp)




# search_rec(@distance, @nextData)

# search_rec(@distance, @nextData)



  # @neighbours_cordinates = @neighboursData.map { |d| d.location.coordinates  } 
  #  puts "*******@neighbours_Coordinates1***"
  # puts @neighbours_cordinates
  # puts @neighbours_cordinates.length


  # unless (@neighbours_cordinates.length == 10) 
   
  #    @neighbours_cordinates = @neighbours_cordinates.map{ |x| search(@distance, x)}
  #  # @neighboursData.map{ |x| search_rec(@distance, x.location.coordinates)}

  #  puts "*******@neighboursData2***"
  # puts @neighbours_cordinates
    
  # end   
  
# end
# @present = @temp.map { |p| search_rec(@distance, p) }
#@present = search_rec(@distance, @present)


# def search_neighbours(c, d)

#   @queryData = Place.geo_near(c).spherical.max_distance(d)


#   puts "****@queryData******"
#   puts @queryData.map { |e| e._id }

#   if @queryData.nil?
#      @queryData = Place.geo_near(c).spherical.max_distance(1)
#    end


# @neighbours_data = @queryData


#   @neighbours_array = @neighbours_data.map{|d| d._id}
#   @neighbours_cordinates = @neighbours_data.map {|d| d.location.coordinates}
#   puts "****@neighbours_cordinates******"
#   puts @neighbours_cordinates
#   puts "******************************"
#   @present = @neighbours_cordinates

# # return @present, @neighbours_cordinates, @neighbours_array

  
# end
# @d = 0.00001
# search_neighbours(@temp[0], @d)



#   @pre = @present.map { |n| search_neighbours(n, @d) }.uniq 



#   #@pre = @present.map { |n| search_neighbours(n, @d) }
    
 

#   puts "**********"
#   puts @queryData.map { |e| e._id }


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

  def BranchMethod
    
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

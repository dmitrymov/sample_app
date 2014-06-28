require 'rubygems'
require 'date'

class UsersController < ApplicationController

  def show
    @user = get_user
    @days_of_week = weekdays(1)
    @days_of_week2 = weekdays(2)
    #@schedule = [true,true,true]
	  SubmitedHour.all
    submitedHour = SubmitedHour.find_by(:week_start_date =>  getStartDate, :user_id => @user.id)
    @arr = Hash.new
    if submitedHour.nil?
      @arr['Sunday'] = false
      @arr['Monday'] = false
      @arr['Tuesday'] = false
      @arr['Wednesday'] = false
      @arr['Thursday'] = false
      @arr['Friday'] = false
      @arr['Saturday'] = false
      return
    end

    @arr = Hash.new
    @arr['Sunday'] = submitedHour.Sunday_morning
    @arr['Monday'] = submitedHour.Monday_morning
    @arr['Tuesday'] = submitedHour.Tuesday_morning
    @arr['Wednesday'] = submitedHour.Wednesday_morning
    @arr['Thursday'] = submitedHour.Thursday_morning
    @arr['Friday'] = submitedHour.Friday_morning
    @arr['Saturday'] = submitedHour.Saturday_morning

    #puts "#{@arr['Sunday']}"

  end

  def new
    @user = User.new

  end

   def edit
     @user = User.find(params[:id])
   end

   def settings
     @user = get_user
   end

    def show_calendar

    end

   def update
     @user = User.find params[:id]
     #create function that will do it
     @user.update_attribute(:name, params[:user][:name])
     @user.update_attribute(:l_name, params[:user][:l_name])
     @user.update_attribute(:phone, params[:user][:phone])
     @user.update_attribute(:email, params[:user][:email])
     @user.update_attribute(:id_number, params[:user][:id_number])
     @user.update_attribute(:position, params[:user][:position])
     @user.update_attribute(:shabat, params[:user][:shabat])
     @user.update_attribute(:admin, params[:user][:admin])
     flash[:notice] = "#{@user.name} was successfully updated."
     redirect_to showall_path
   end

    def change_password
      @user = get_user
    end

    def update_password
      @user = get_user
    end

   def create
     @user = User.new(user_params)
     if @user.save
       flash[:success] = "Welcome to the Schedule App!"
       #sign_in @user  # only Admin will add new users
       redirect_to @user
     else
       render 'new'
     end
   end

  def destroy
    User.destroy(params[:id])
    redirect_to root_path
  end

  def allschedule
    week_select = @week
    @days_of_week = weekdays(week_select)
  end

  def submit
    arr = Hash.new
    params['string'].split('$').each do |param|
      splitted = param.split('=')
      arr[splitted[0]] = splitted[1]
    end
    create_events(arr)
    puts ''

  end

  def submit_part
    arr = Hash.new
    params['string'].split('$').each do |param|
      splitted = param.split('=')
      arr[splitted[0]] = splitted[1]
    end
    create_events_for_part(arr)
  end

   private

   def user_params
     params.require(:user).permit(:name, :l_name, :phone, :email, :password,
                                  :password_confirmation, :id_number, :position, :shabat, :admin)
   end

  def check_user
    usr_id = User.find(usr_id)
    usr_check = User.find_by(remember_token: remember_token)
    if(usr_id != usr_check)
      redirect_to root_path
    end
  end

  def weekdays(week)
    t = Time.now
    t +=   (60*60*24*7) if week == 2
    ans = Hash.new
    temp_t = t.wday
    while temp_t != 0
      t -= (60*60*24)
      temp_t = t.wday
    end
    7.times do
      ans[t.wday] = t.strftime("%d/%m/%Y")
      t += (60*60*24)
    end
    ans
  end

  def create_events(parsed_string)

    hours = SubmitedHour.find_by(:week_start_date =>  getStartDate, :user_id => current_user.id)
    if (hours.nil?)
      hours = SubmitedHour.create!
      hours.user_id =  current_user.id
      hours.week_start_date= getStartDate
    end




    #parsed_string.each_with_index do |key, index|

      #case key[0]
      #  when 'Sunday'


      hours.Sunday_morning=parsed_string['Sunday']
      hours.Sunday_evening=parsed_string['Sunday']
      hours.Sunday_night=parsed_string['Sunday']



      hours.Monday_morning=parsed_string['Monday']
      hours.Monday_evening=parsed_string['Monday']
      hours.Monday_night=parsed_string['Monday']



      hours.Tuesday_morning=parsed_string['Tuesday']
      hours.Tuesday_evening=parsed_string['Tuesday']
      hours.Tuesday_night=parsed_string['Tuesday']



      hours.Wednesday_morning=parsed_string['Wednesday']
      hours.Wednesday_evening=parsed_string['Wednesday']
      hours.Wednesday_night=parsed_string['Wednesday']



      hours.Thursday_morning=parsed_string['Thursday']
      hours.Thursday_evening=parsed_string['Thursday']
      hours.Thursday_night=parsed_string['Thursday']



      hours.Friday_morning=parsed_string['Friday']
      hours.Friday_evening=parsed_string['Friday']
      hours.Friday_night=parsed_string['Friday']



      hours.Saturday_morning=parsed_string['Saturday']
      hours.Saturday_evening=parsed_string['Saturday']
      hours.Saturday_night=parsed_string['Saturday']

    hours.save!

    puts ''

  end

  def create_events_for_part(parsed_string)

    hours = SubmitedHour.find_by(:week_start_date =>  getStartDate, :user_id => current_user.id)
    if (hours.nil?)
      hours = SubmitedHour.create!
      hours.user_id =  current_user.id
      hours.week_start_date= getStartDate
    end

    hours.Sunday_morning=parsed_string['Sunday']['morning']
    hours.Sunday_evening=parsed_string['Sunday']
    hours.Sunday_night=parsed_string['Sunday']

    hours.Monday_morning=parsed_string['Monday']
    hours.Monday_evening=parsed_string['Monday']
    hours.Monday_night=parsed_string['Monday']

    hours.Tuesday_morning=parsed_string['Tuesday']
    hours.Tuesday_evening=parsed_string['Tuesday']
    hours.Tuesday_night=parsed_string['Tuesday']

    hours.Wednesday_morning=parsed_string['Wednesday']
    hours.Wednesday_evening=parsed_string['Wednesday']
    hours.Wednesday_night=parsed_string['Wednesday']

    hours.Thursday_morning=parsed_string['Thursday']
    hours.Thursday_evening=parsed_string['Thursday']
    hours.Thursday_night=parsed_string['Thursday']

    hours.Friday_morning=parsed_string['Friday']
    hours.Friday_evening=parsed_string['Friday']
    hours.Friday_night=parsed_string['Friday']

    hours.Saturday_morning=parsed_string['Saturday']
    hours.Saturday_evening=parsed_string['Saturday']
    hours.Saturday_night=parsed_string['Saturday']

    hours.save!

    puts ''

  end


    def index_to_day(index)
      case index
        when 1
          'Sunday'
        when 2
          'Monday'
        when 3
          'Tuesday'
        when 4
          'Wednesday'
        when 5
          'Thursday'
        when 6
          'Friday'
        when 7
          'Saturday'
      end
    end

    def get_user
      remember_token = User.encrypt(cookies[:remember_token])
      User.find_by(remember_token: remember_token)
    end

def getStartDate
    day = 8
    month = 6
    year = 2014

    day_start = Time.now.change({:year => year, :month => month, :day => day , :hour => 0 ,  :min => 0 ,  :sec => 0  })
    day_start
  end

end

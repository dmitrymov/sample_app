module UsersHelper

  def getClass(day)
    @arr[day]?'selectedCell':''
  end

  def week_change()
    @week = params[:w]
    cookies.permanent[:week] = @week
  end



end

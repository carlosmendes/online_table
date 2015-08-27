class PagesController < ApplicationController
  def home
    
    #first time create cookie
    if get_unregistered_cookie.blank?
      @first_visit = true
      create_unregistered_cookie
    end
    
  end
  
end
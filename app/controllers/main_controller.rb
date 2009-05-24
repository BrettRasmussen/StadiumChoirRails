class MainController < ApplicationController
  def signup
    @singer = Singer.new
  end

  def do_signup
    @singer = Singer.new(params[:singer])
    @singer.status = params[:committed] == 'true' ? 'committed' : 'interested'
    if @singer.save
      render :template => 'main/signup_thanks'
    else
      render :action => :signup
    end
  end

  def orig
    render :layout => false
  end
end

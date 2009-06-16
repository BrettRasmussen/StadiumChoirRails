class AdminController < ApplicationController
  before_filter :authorize, :except => %w[login try_login]

  def index
    @singers = Singer.find(:all, :conditions => "status_id = 4")
    @singers = @singers.sort_by {|s| s.last_name.downcase + s.first_name.downcase}
    calculate_email_dupes
    @part_counts = Hash.new(0)
    @singers.each {|s| @part_counts[s.voicepart] += 1}
    @voiceparts = Voicepart.all
  end

  def email_list
    sql = "select distinct(email) from singers where status_id = 4"
    @email_addresses = ActiveRecord::Base.connection.select_values(sql)
  end

  def duplicates
    @singers = Singer.find(:all, :conditions => "status_id = 4")
    calculate_email_dupes
  end

  def try_login
    if [params[:username], params[:password]] == %w[stadiumchoir Blu3.not3]
      session[:admin] = true
      redirect_to :action => "index"
    else
      render :action => "login"
    end
  end

  def authorize
    redirect_to :action => "login" unless session[:admin] == true
  end

  protected

  def calculate_email_dupes
    if !@singers.empty?
      @email_dupes = {}
      @singers.each do |s|
        email = s.email.strip
        @email_dupes[email] ||= {}
        @email_dupes[email][:objects] ||= []
        @email_dupes[email][:objects] << s
      end
      @email_dupes.delete_if {|k,v| v[:objects].size < 2}

      @attrs = @singers[0].attributes.keys - %w[created_at updated_at]

      @email_dupes.each do |email,val|
        differences = {}
        @attrs.each do |attr|
          values = val[:objects].collect {|so| eval("so.#{attr}")}
          differences[attr] = values if values.uniq.size > 1
        end
        @email_dupes[email][:differences] = differences
      end
      @email_dupes.delete_if {|k,v| v[:differences].has_key?('first_name')}
    end
  end

end

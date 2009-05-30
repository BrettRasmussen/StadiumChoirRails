require 'ruby-debug'
class AdminController < ApplicationController
  layout false

  def index
    @singers = Singer.all

    # Deal with entries with duplicate addresses
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
    end
  end

end

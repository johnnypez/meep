require 'httparty'
require "meep/version"
require "meep/tracker"
module Meep
  extend self

  def tracker_id
    @tracker_id
  end

  def tracker_id=(value)
    @tracker = nil
    @tracker_id = value
  end

  def tracker
    @tracker ||= Tracker.new
  end

  # allow calling tracker methods on main Meep object
  def method_missing(name, *args)
    if tracker.respond_to? name
      tracker.send name, *args
    else
      super
    end
  end

end

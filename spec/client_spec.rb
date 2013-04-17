require 'spec_helper'

describe Meep::Tracker do
  it "should allow setting tracker id" do
    Meep.tracker_id = 'UA-40169889-1'
    Meep.tracker_id.should eq 'UA-40169889-1'
  end

  it "should do basic collect data" do
    res = Meep.collect t: 'event', cid: 'userA', ec: 'Test Category', ea: 'Test Action 1', el: 'running a test'
    res.code.should eq 200
  end

  it "should track events" do
    res = Meep.event 'Test Category', 'Test Action 2', user: 'userA', label: 'running a second test'
    res.code.should eq 200
  end

  it "should track pageviews" do
    res = Meep.pageview 'http://hodor.wat.betapond.com', user: 'userA'
    res.code.should eq 200
  end

end
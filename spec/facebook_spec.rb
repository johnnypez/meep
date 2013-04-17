require 'spec_helper'
require 'meep/facebook'

describe Meep::Facebook do

  it "should track auths" do
    res = Meep.fb_auth 'userA'
    res.code.should eq 200
  end

  it "should track deauths" do
    res = Meep.fb_deauth 'userA'
    res.code.should eq 200
  end

  it "should track action referrals" do
    res = Meep.fb_action_referral "thedoveapp:compliment", user: 'userA', action_id: "10151351033270737", object_id: '360985147344774'
  end

end
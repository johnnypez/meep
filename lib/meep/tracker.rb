module Meep
  # A Tracker client for Google's Measurement Protocol
  # https://developers.google.com/analytics/devguides/collection/protocol/v1/
  # For now I am just implementing what I need to collect events that can only be triggerd server-side
  # See the ga.js or analytics.js docs for anything else
  class Tracker
    include HTTParty
    
    base_uri "https://ssl.google-analytics.com"
    
    attr_reader :tracker_id
    
    def initialize(tracker_id = Meep.tracker_id)
      @tracker_id = tracker_id
    end

    # https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#events
    # https://developers.google.com/analytics/devguides/collection/gajs/eventTrackerGuide
    # event 'Posts', 'Create', user: user.tracking_id, label: 'Hello World!'
    # event 'Subscribe', 'Weekly', user: user.tracking_id, label: 'Purchase Weekly Sub', value: 10
    def event(category, action, opt = {})
      require_keys! opt, :user
      data = {
        t: 'event',
        ec: category,
        ea: action,
        cid: opt.delete(:user),
        el: opt.delete(:label),
        ev: opt.delete(:value)
      }.merge(opt)
      collect data
    end

    # https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#social
    # social 'facebook', 'auth', user: user.tracking_id
    def social(network, action, opt = {})
      require_keys! opt, :user
      data = {
        t: 'social',
        sn: network,
        sa: action,
        cid: opt.delete(:user),
        st: opt.delete(:target)
      }.merge(opt)
      collect data
    end

    def pageview(url, opt = {})
      require_keys! opt, :user
      data = {
        t: 'pageview',
        dl: url,
        dr: opt.delete(:referrer),
        cid: opt.delete(:user)
      }.merge(opt) 
      collect data
    end

    def campaign(name, source, medium, opt = {})
      url = opt.delete(:url)
      data = {
        cn: name,
        cs: source,
        cm: medium,
        ck: opt.delete(:keyword),
        cc: opt.delete(:content),
        ci: opt.delete(:id)
      }.merge(opt)
      pageview url, data 
    end

    def collect(data = {})
      data = {v: 1, tid: tracker_id}.merge(data).reject{|k,v| v.nil? }
      require_keys!(data, :v, :tid, :cid, :t)
      puts "/collect -> #{data.inspect}"
      self.class.post('/collect', :body => data)
    end

    private

    def require_keys!(data, *required)
      (missing = (required - data.keys)).empty? or raise "missing required options #{missing.inspect}"
    end
  end
end
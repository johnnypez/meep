module Meep
  module Facebook

    # Meep.facebook_auth('e66e5ad5-f104-4513-afeb-b3d6b5d89170')
    def fb_auth(user, target = nil)
      social 'facebook', 'auth', user: user, target: target
    end

    # Meep.fb_deauth('e66e5ad5-f104-4513-afeb-b3d6b5d89170')
    def fb_deauth(user, target = nil)
      social 'facebook', 'deauth', user: user, target: target, sc: 'end'
    end

    # Meep.fb_action_referral 'meepapp:publish', user: current_user.tracking_id, action_id: '10151351033270737', object_id: '360985147344774'
    def fb_action_referral(action_type, opt = {})
      data = {
        content: opt.delete(:object_id),
        id: opt.delete(:action_id)
      }.merge(opt)
      campaign action_type, 'facebook', 'open_graph', data
    end

  end

  Tracker.send :include, Facebook
end
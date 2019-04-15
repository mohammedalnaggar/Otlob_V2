class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, :class_name => 'User'

    after_commit :friended, on: :create 
    after_commit :unfriended, on: :destroy

    private

    def friended
        Notification.create(notify_type: 'follow', actor: self.user, user: self.friend, target: self.friend)
    end
    
    def unfriended
        Notification.create(notify_type: 'unfriend', actor: self.user, user: self.friend, target: self.friend)
    end
end

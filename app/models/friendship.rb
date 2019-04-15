class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, :class_name => 'User'

    after_commit :follow, on: :create
    
    private

    def follow
        Notification.create(notify_type: 'follow', actor: self.user, user: self.friend, target: self.friend)
    end
    
end

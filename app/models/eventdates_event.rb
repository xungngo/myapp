class EventdatesEvent < ActiveRecord::Base
    belongs_to :event
    belongs_to :eventdate
    
    validates :event_id, presence: {message: "The Event ID is required."}
    validates :eventdate_id, presence: {message: "The Eventdate ID is required."}

=begin
the 2 validation above doesn't seem to work!
    validates_associated
    validate :at_most_3_roles, on: :update

    def at_most_3_roles
        duplicates = UserRole.where(user_id: user_id, role_id: role_id).where('id != ?', id)
        if duplicates.count > 3
        errors.add(:base, 'A user may have at most three roles')
        end
    end
=end
end

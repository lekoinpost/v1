class Conversation < ApplicationRecord

  belongs_to :appointment
  has_many :messages

  scope :involving_user, ->(user) { joins(:appointment).where("appointments.giver_id = ? OR appointments.gardener_id = ?", user.id, user.id) }

  scope :with_messages, -> { joins(:messages).distinct }
end

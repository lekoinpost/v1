class Conversation < ApplicationRecord

  belongs_to :appointment
  has_many :messages

  scope :involving_user, ->(user) { joins(:appointment).where("appointments.giver_id = ? OR appointments.gardener_id = ?", user.id, user.id) }

  scope :with_messages, -> { joins(:messages).distinct }

  def counterpart_user(user)
    if self.appointment.giver_id == user.id
      self.appointment.gardener.garden.garden_name
    elsif self.appointment.gardener_id == user.id
      self.appointment.giver.full_name
    else
      nil
    end
  end

end

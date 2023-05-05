class Appointment < ApplicationRecord

  validates :date, :quantity, :compost_type, presence: true
  
  COMPOST_TYPES = ["biodéchets", "compost mûr"]

end
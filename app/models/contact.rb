class Contact < ApplicationRecord

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :content, presence: true

end
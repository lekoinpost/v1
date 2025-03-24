class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many_attached :attachments

  validate :attachments_size_within_limit

  private

  def attachments_size_within_limit
    attachments.each do |attachment|
      if attachment.blob.byte_size > 3.megabytes
        errors.add(:attachments, "doivent être inférieurs à 3 Mo")
      end
    end
  end
end

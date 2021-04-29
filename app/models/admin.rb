class Admin < ApplicationRecord
  validates :mobile, presence: true,
            format: {with: /\A\d{10}\z/, message: "Mobile number should be valid"},
            uniqueness: true
  validates :otp, presence: true,
            format: {with: /\A\d{6}\z/, message: "Otp should be 6 digit number"}
end

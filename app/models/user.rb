class User < ActiveRecord::Base
  before_validation :downcase_email

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :presence => true, :uniqueness => true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates_length_of :password, :minimum => 5
  validates_uniqueness_of :email

  validate :check_password_is_equal

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def check_password_is_equal
    errors.add(:password, "passwords must match") if password_confirmation != password
  end
end

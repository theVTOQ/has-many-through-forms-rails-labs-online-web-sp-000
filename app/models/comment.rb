class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  accepts_nested_attributes_for :user, reject_if: proc {|attrs| attrs['user'].blank? }
=begin
  def user_attributes=(user_attributes)
    user_attributes.values.each do |user_attr|
      user = User.find_or_create_by(user_attr)
      self.user = user
    end
  end
=end
end

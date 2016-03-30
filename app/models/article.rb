class Article < ActiveRecord::Base

  belongs_to :user


  validates  :title, presence: true, length: { minimum: 3 ,maximum: 70}
  validates  :description, presence: true, length: { minimum: 20 ,maximum: 1000}
  validates  :user_id, presence: true
end

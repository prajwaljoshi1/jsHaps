class Article < ActiveRecord::Base
  validates  :title, presence: true, length: { minimum: 3 ,maximum: 70}
  validates  :description, presence: true, length: { minimum: 20 ,maximum: 1000}
end

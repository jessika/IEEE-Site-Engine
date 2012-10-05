class Donation < ActiveRecord::Base
  validates_presence_of :name, :amount, :description
end

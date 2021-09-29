class Discount < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :percentage, numericality: {only_integer: true}, presence: true
  validates_presence_of :threshold, numericality: {only_integer: true}, presence: true

  belongs_to :merchant
end

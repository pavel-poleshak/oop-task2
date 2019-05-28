require './application_record'

class Company < ApplicationRecord
  has_many :employees
end

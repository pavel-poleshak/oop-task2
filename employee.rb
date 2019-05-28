require './application_record'

class Employee < ApplicationRecord
  belongs_to :company
end

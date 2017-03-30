class Student < ActiveRecord::Base
	validates :name,:phone,:course,:matricula, presence: true
  validates :matricula, uniqueness: true
end
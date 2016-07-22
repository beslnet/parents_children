class Person < ActiveRecord::Base
	has_many :marriages
	has_many :spouse, through: :marriages,
                         	  dependent: :destroy
	has_many :children
	has_many :mothers, through: :children,
                         	  dependent: :nullify
	has_many :children
	has_many :fathers, through: :children,
                         	  dependent: :nullify
end

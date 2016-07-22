class Child < ActiveRecord::Base
  belongs_to :person
  belongs_to :mother, class_name: 'Person'
  belongs_to :father, class_name: 'Person'
end

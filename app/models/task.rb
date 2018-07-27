class Task < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :assigned, class_name: 'User', optional: true
end

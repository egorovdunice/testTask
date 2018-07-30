class Task < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :assigned, class_name: 'User', optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[new started finished],
                                                  message: 'Status should be new, started or finished' }
end

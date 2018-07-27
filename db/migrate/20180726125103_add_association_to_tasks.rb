class AddAssociationToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :owner
    add_reference :tasks, :assigned
  end
end

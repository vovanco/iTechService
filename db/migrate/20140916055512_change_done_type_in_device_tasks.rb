class ChangeDoneTypeInDeviceTasks < ActiveRecord::Migration
  def up
    change_column :device_tasks, :done, 'integer USING CAST(done AS integer)', limit: 1
    change_column_default :device_tasks, :done, 0
  end

  def down
  end
end

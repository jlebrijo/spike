class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.boolean :done
      t.string :title

      t.timestamps
    end
  end
end

class CreateStat < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :event_id
      t.boolean :status
    end
  end
end

class CreateBugs < ActiveRecord::Migration[6.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.date :deadline
      t.binary :screenshot
      t.string :type
      t.string :status
      t.references :creator, null: false, foreign_key: true
      t.references :developer, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end

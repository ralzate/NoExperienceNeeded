class CreateTitleTypes < ActiveRecord::Migration
  def change
    create_table :title_types do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end

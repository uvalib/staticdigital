class CreateStaticdcs < ActiveRecord::Migration[5.2]
  def change
    create_table :staticdcs do |t|
      t.string :name
      t.boolean :public
      t.string :address

      t.timestamps
    end
  end
end

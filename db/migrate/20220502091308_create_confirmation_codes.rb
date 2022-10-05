class CreateConfirmationCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :confirmation_codes do |t|
      t.string :phone
      t.string :code
      t.string :event_type
      t.string :status
      t.timestamps
    end
  end
end

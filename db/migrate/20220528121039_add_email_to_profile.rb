class AddEmailToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :email, :string
    add_column :profiles, :reason_for_web_three, :string
    add_column :profiles, :understand_web_three, :string
    add_column :profiles, :steps, :text
  end
end

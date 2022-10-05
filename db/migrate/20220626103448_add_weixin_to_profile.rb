class AddWeixinToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :weixin, :string
  end
end

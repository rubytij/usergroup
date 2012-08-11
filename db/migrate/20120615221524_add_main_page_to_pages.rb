class AddMainPageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :main_page, :boolean
  end
end

class RenameBioToAbout < ActiveRecord::Migration
  def up
    Block.where(label: 'bio').update_all(label: 'about', path: '/about')
  end

  def down
    Block.where(label: 'about').update_all(label: 'bio', path: '/bio')
  end
end

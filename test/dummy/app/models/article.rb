class Article < ActiveRecord::Base
  after_save :on_save

  def on_save
    puts "original model after_save callback"
  end

end

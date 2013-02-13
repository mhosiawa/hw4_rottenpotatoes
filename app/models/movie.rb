class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar(m)
  	Movie.where(:director => m.director).where(['id != ?', m.id]).all
  end
end

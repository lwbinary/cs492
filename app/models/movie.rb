class Movie < ActiveRecord::Base
	validates :title, :presence => true
	validates :release_date, :presence => true
	validate :title_char_limit # uses custom validator below
	validates_uniqueness_of :title

	def title_char_limit
		errors.add(:title, 'has at least 3 chars') if
		self.title.length < 3
	end

	before_save :capitalize_title # capitalize title before save
  	def capitalize_title
   		self.title = self.title.split(/\s+/).map(&:downcase).
        map(&:capitalize).join(' ')
  end
end

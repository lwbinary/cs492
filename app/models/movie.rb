class Movie < ActiveRecord::Base
<<<<<<< HEAD
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
=======
  # Returns an array containing allowed  values for ratings
  def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end

  # Validate model fields
  validates :title, :presence => true, :uniqueness => true, :length => { :minimum => 3 }
  validates :release_date, :presence => true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, :inclusion => {:in => Movie.all_ratings},
    :unless => :grandfathered?

  # Check that release date is greater than Jan 1, 1930.
  # Set error if otherwise.
  def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
      release_date && release_date < Date.parse('1 Jan 1930')
  end

  # The rating system did not go into effect until Nov 1, 1968.
  # Therefore, ignore ratings validation for movies released
  # prior to this.
  @@grandfathered_date = Date.parse('1 Nov 1968')
  def grandfathered?
    release_date && release_date >= @@grandfathered_date
>>>>>>> 3948923ac1e6019cca4153111c478e2714e830f6
  end
end

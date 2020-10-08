class Song < ApplicationRecord
  require 'date'

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:release_year, :artist_name],
    message: "can only release same song once per year" } 
  validates :artist_name, presence: true
  validates :released, inclusion: { in: [ true, false ] }
  with_options if: :year_presence? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: { only_integer: true, less_than_or_equal_to: Date.current.year }
  end

  

  def year_presence?
    self.released == true
  end

  # def release_year_cannot_be_in_the_future
  #   if self.release_year > 2020
  #     errors.add(:release_year, "can't be later than this year")
  #   end
  # end


end

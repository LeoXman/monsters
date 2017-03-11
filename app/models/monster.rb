class Monster < ActiveRecord::Base
  has_many :comments
  accepts_nested_attributes_for :comments
  def self.name_starts_with(letter)
    where("UPPER(name) LIKE UPPER(?)", "#{letter}%")
  end
  def self.letter(letter)
    name_starts_with(letter).by_name
  end
  def self.letterize(letter)
    letter =~ /\A[A-Za-z]\z/ ? letter.upcase : 'A'
  end
  def self.by_name
    order(name: :asc)
  end
  # Validations
  validates :name, presence: true
  validates :level, numericality: true
  validates :hp, numericality: true
  validates :exp, numericality: true
  validates :jexp, numericality: true
  validates :atk1, numericality: true
  validates :atk2, numericality: true
  validates :def, numericality: true
  validates :mdef, numericality: true
  validates :str, numericality: true
  validates :agi, numericality: true
  validates :vit, numericality: true
  validates :int, numericality: true
  validates :dex, numericality: true
  validates :luk, numericality: true
  validates :scale, numericality: true
  validates :race, numericality: true
  validates :element, numericality: true
end

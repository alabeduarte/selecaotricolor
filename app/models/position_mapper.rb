class PositionMapper
  include MongoMapper::Document

  key :x_min, Integer
  key :x_max, Integer
  key :y_min, Integer
  key :y_max, Integer
  key :description, String
  key :code, String

  many :players

  validates :x_min, :presence => true, :numericality => true
  validates :x_max, :presence => true, :numericality => true
  validates :y_min, :presence => true, :numericality => true
  validates :y_max, :presence => true, :numericality => true
  validates :description, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

end

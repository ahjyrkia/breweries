class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }
  validates :password, length: {minimum: 3}
  validates :password, :format => {:with => /[a-z]+[A-Z].*[0-9].*{4,15}/}

  has_many :ratings
end

class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

  def to_s
    "#{beer.name} #{score}"
  end
end

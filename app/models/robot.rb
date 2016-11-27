class Robot < ApplicationRecord
  has_many :technicians

  def greet
    if self.friendly
      "Hello Human"
    else
      "Die Human"
    end
  end

  def attack
    !self.friendly
  end
end

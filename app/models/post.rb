class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates_inclusion_of :category, in: %w( Fiction Non-Fiction )
  validate :clickbait_check

  def clickbait_check
    if title != nil
      conditions = [/Won't Believe/, /Secret/, /Top\[\d\]/, /Guess/]
      result = conditions.detect do |condition|
        title.match(condition)
        end
      end
      if result == nil
        errors.add(:title, "not clickbait-y")
      end
    end

end

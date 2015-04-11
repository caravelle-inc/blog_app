class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :favorite_articles

  validates :title,
            presence: { message: "タイトルを入力してください" },
            length: { minimum: 3, message: "3文字以上入力してください" }

  validates :content,
            presence: { message: "コメントを入力してください" },
            length: { in: 5..20 , message: "10文字以上20文字以内で入力してください" }

  validates :movie,
            presence: { message: "youtubeのURLを入れてください" }
            # if: :youtube_url?

  # validate :check_url

  # def youtube_url?
  #   movie.include?("https://www.youtube.com")
  # end


  # private
  #
  # def check_url
  #   if
  #
  # end

end





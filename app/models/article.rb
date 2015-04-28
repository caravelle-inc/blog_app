class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :favorite_articles, :dependent => :destroy

  validates :title,
            presence: { message: "タイトルを入力してください" },
            length: { minimum: 3, message: "3文字以上入力してください" }

  validates :content,
            presence: { message: "コメントを入力してください" },
            length: { in: 5..20 , message: "10文字以上20文字以内で入力してください" }

  validates :movie,
            presence: { message: "youtubeのURLを入れてください" }

  paginates_per 1  # 1ページあたりの表示件数


end





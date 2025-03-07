class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[一-龠々ぁ-んァ-ヴー]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[一-龠々ぁ-んァ-ヴー]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/ }
  validates :birth_date, presence: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/ }

  # has_many :items
  # has_many :purchases
end

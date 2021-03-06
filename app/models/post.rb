class Post < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :model
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :model_id, presence: true
  validates :image, presence: true
  validates :caption, length: { minimum: 3, maximum: 300 }

  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :of_followed_models, -> (following_models) { where model_id: following_models }
end
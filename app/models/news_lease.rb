class NewsLease < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :place, optional: true, dependent: :destroy
  belongs_to :image, optional: true, dependent: :destroy
  accepts_nested_attributes_for :place, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :image, allow_destroy: true, update_only: true

  scope :select_newslease, -> {select :id, :image_id, :category_id, :product_name, :status}
  scope :load_myleases, -> myuser {where user_id: myuser}
  scope :order_desc, -> {order(created_at: :desc)}
  scope :select_views_hot, -> {select :id, :image_id, :category_id, :product_name, :place_id, :price_type, :price_value}
  scope :approved, -> (status){where status: status}
  scope :order_desc_views, -> {order(views: :desc)}
  is_impressionable
  ratyrate_rateable "quality"
end

class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_items

  validates :title, :description, :image_url, presence: true

  validates :title, uniqueness: true, length: {minimum: 10, too_short: "must have a minimum of %{count} characters."}

  validates :image_url, allow_blank: true,
  format: {
    with:   %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG of PNG image.'}

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  private
  def ensure_not_referenced_by_any_line_items
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

end

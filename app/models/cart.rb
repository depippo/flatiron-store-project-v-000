class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    total = 0
    self.line_items.each do |line_item|
      total += (line_item.item.price * line_item.quantity)
    end
    total
  end

  def add_item(item)
    line_item = self.line_items.find_by(item_id: item)
    if line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(item_id: item, quantity: 1)
    end
    line_item
  end

  def checkout
    self.status = "submitted"
    line_items.each do |line_item|
      @item = Item.find(line_item.item_id)
      @item.inventory -= line_item.quantity
      @item.save
    end
  end

end
module PistaaHelper
  def render_pistaa_slot(slot)
    pistaa_slot_items(slot).map do |item|
      next if pistaa_slot_item_hidden?(slot, item)

      render_pistaa_slot_item(slot, item)
    end.join("\n").html_safe
  end

  def render_pistaa_slot_item(slot, item)
    hide_pistaa_slot_item(slot, item)
    render partial: Pistaa[slot][item]
  end

  def pistaa_slot_items(slot)
    Pistaa[slot].item_keys
  end

  def pistaa_hidden_items
    @pistaa_hidden_items ||= []
  end

  def hide_pistaa_slot_item(slot, item)
    pistaa_hidden_items << [slot, item]
  end

  def pistaa_slot_item_hidden?(slot, item)
    pistaa_hidden_items.include? [slot, item]
  end
end
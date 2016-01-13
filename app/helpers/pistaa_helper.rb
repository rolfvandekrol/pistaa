module PistaaHelper

  # Render all templates in the slot, but skip the items that are registered as
  # hidden. It repeatedly calls `render_pistaa_slot_item`, so the rendered
  # templates will be registered as hidden.
  def render_pistaa_slot(slot, *args)
    capture do
      pistaa_slot_items(slot).each do |item|
        next if pistaa_slot_item_hidden?(slot, item)

        concat(render_pistaa_slot_item(slot, item, *args))
      end
    end
  end

  # Render a specific template from a slot (regardless of it was hidden), and
  # register it as hidden, so it won't be rendered if `render_pistaa_slot` is 
  # called. 
  def render_pistaa_slot_item(slot, item, *args)
    options = args.extract_options!
    
    hide_pistaa_slot_item(slot, item)

    options[:partial] = Pistaa[slot][item]
    render options
  end

  # List all the keys of the items in the slot.
  def pistaa_slot_items(slot)
    Pistaa[slot].item_keys
  end

  # Helper to access the hidden items. You shouldn't need to access this helper
  # from the template. Use `pistaa_slot_item_hidden?` and 
  #{ }`hide_pistaa_slot_item` instead.
  def pistaa_hidden_items
    @pistaa_hidden_items ||= []
  end

  # Register a template as hidden, so it won't be rendered with 
  # `render_pistaa_slot`.
  def hide_pistaa_slot_item(slot, item)
    pistaa_hidden_items << [slot, item]
  end

  # Check if a template is hidden.
  def pistaa_slot_item_hidden?(slot, item)
    pistaa_hidden_items.include? [slot, item]
  end
end
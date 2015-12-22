require "pistaa/engine"

module Pistaa
  class << self
    def [](slot_key)
      slots[slot_key]
    end

    def slot_keys
      slots.keys
    end

    protected

    def slots
      @slots ||= Hash.new do |hash, key| 
        hash[key] = Pistaa::Slot.new
      end
    end
  end

  class Slot
    def [](item_key)
      raise IndexError if items[item_key.to_sym].nil?
      items[item_key.to_sym]
    end

    def []=(item_key, template)
      items[item_key.to_sym] = template
    end

    def item_keys
      items.keys
    end

    protected

    def items
      @items ||= Hash.new
    end
  end
end

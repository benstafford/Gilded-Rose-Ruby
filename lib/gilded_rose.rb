module GildedRose
  class Item
    attr_reader :days_remaining, :quality

    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick; end
  end

  class Normal < Item
    def tick
      @days_remaining -= 1
      return if @quality.zero?

      @quality -= 1
      @quality -= 1 if @days_remaining <= 0
    end
  end

  class Brie < Item
    def tick
      @days_remaining -= 1
      return if @quality >= 50

      @quality += 1
      @quality += 1 if @days_remaining <= 0 && @quality < 50
    end
  end

  class Backstage < Item
    def tick
      @days_remaining -= 1
      return if @quality >= 50
      return @quality = 0 if @days_remaining < 0

      @quality += 1
      @quality += 1 if days_remaining < 10
      @quality += 1 if days_remaining < 5
    end
  end

  DEFAULT_CLASS = Item
  SPECIALIZED_CLASSES = {
    'Normal Item' => Normal,
    'Aged Brie' => Brie,
    'Backstage passes to a TAFKAL80ETC concert' => Backstage
  }
  def self.for(name:, days_remaining:, quality:)
    (SPECIALIZED_CLASSES[name] || DEFAULT_CLASS).new(days_remaining, quality)
  end

  def tick
    item.tick
  end

  def quality
    item.quality
  end

  def days_remaining
    item.days_remaining
  end
end

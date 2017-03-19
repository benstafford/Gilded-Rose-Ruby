class GildedRose
  attr_reader :name, :item

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    case name
    when "Normal Item"
      @item = Normal.new(days_remaining, quality)
      item.tick
    when "Aged Brie"
      @item = Brie.new(days_remaining, quality)
      item.tick
    when "Sulfuras, Hand of Ragnaros"
      @item = Sulfuras.new(days_remaining, quality)
      item.tick
    when "Backstage passes to a TAFKAL80ETC concert"
      @item = Backstage.new(days_remaining, quality)
      item.tick
    end
  end

  def quality
    return item.quality if item
    @quality
  end

  def days_remaining
    return item.days_remaining if item
    @days_remaining
  end

  class Normal
    attr_reader :days_remaining, :quality

    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick
      @days_remaining -= 1
      return if @quality.zero?

      @quality -= 1
      @quality -= 1 if @days_remaining <= 0
    end
  end

  class Brie
    attr_reader :days_remaining, :quality

    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick
      @days_remaining -= 1
      return if @quality >= 50

      @quality += 1
      @quality += 1 if @days_remaining <= 0 && @quality < 50
    end
  end

  class Sulfuras
    attr_reader :days_remaining, :quality

    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick; end
  end

  class Backstage
    attr_reader :days_remaining, :quality

    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    def tick
      @days_remaining -= 1
      return if @quality >= 50
      return @quality = 0 if @days_remaining < 0

      @quality += 1
      @quality += 1 if days_remaining < 10
      @quality += 1 if days_remaining < 5
    end
  end
end

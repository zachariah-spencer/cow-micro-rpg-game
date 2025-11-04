require_relative "cow"
require_relative "tick_registry"

class Game
  attr_gtk

  def initialize
    @cow = Cow.new
  end

  def tick
    TickRegistry.tickables.each do |entity|
      entity.args = args if entity.respond_to?(:args=)
      entity.tick if entity.respond_to?(:tick)
    end
    render
  end

  def render
    outputs.background_color = [ 13, 13, 13]

    outputs.primitives << @cow.prefab

    outputs.primitives << {
      x: 200,
      y: 200,
      text: "holy fuck it works",
      r: 255,
      g: 255,
      b: 255,
      size_px: 50,
      primitive_marker: :label,
    }
  end
end
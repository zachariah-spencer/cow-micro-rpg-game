require_relative "tickable"

class Cow
  include Tickable
  attr_gtk

  SPRITE_SCALE = { w: 16, h: 8}

  def initialize
    @position = { x: 400, y: 400 }
    @scale = { w: 64, h: 32 }
    @path = "sprites/cow_idle_16x8_2.png"

    @animations = {
      idle: {
        path: "sprites/cow_idle_16x8_2.png",
        count: 2,
        hold_for: 30,
      },
      walk: {
        path: "sprites/cow_walk_16x8_2.png",
        count: 2,
        hold_for: 30
      }
    }

    @animation_frame = 0
    
    enable_tick!
  end

  def tick
    puts "ticking on cow"
  end

  def rect
    @position.merge @scale
  end

  def prefab
    rect.merge({
      path: @path,
      tile_w: SPRITE_SCALE.w,
      tile_h: SPRITE_SCALE.h,
      tile_x: @animation_frame * SPRITE_SCALE.w,
      primitive_marker: :sprite
    })
  end
end
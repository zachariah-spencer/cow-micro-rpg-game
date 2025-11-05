require_relative "tickable"

class Cow
  include Tickable
  attr_gtk

  SPRITE_SCALE = { w: 16, h: 8}

  def initialize
    @position = { x: 400, y: 400 }
    @velocity = { x: 0, y: 0 }
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
    @target_position = @position

    enable_tick!
  end

  def tick
    calc_input
    @position = Geometry.vec2_add @position, @velocity
  end

  def calc_input
    @target_position = { x: inputs.mouse.x, y: inputs.mouse.y } if inputs.mouse.click
    # outputs.debug << "TARGET POSITION: #{@target_position}"
    # outputs.debug << "POSITION: #{@position}"
    # outputs.debug << "IS POSITIONS APPROX EQUAL? #{approximately_equal? @position.values, @target_position.values}"
    if approximately_equal? @position.values, @target_position.values
      @velocity = { x: 0, y: 0 }
      return
    end
    
    line_to_target = Geometry.vec2_sub(@target_position, @position)
    @velocity = Geometry.vec2_scale line_to_target, 0.08
    @velocity.transform_values! { |v| v.clamp(-5.0, 5.0) }
  end



  def approximately_equal?(a, b, tolerance: 0.5)
    # Check if arrays have the same length
    return false if a.length != b.length

    a.zip(b).all? do |val_a, val_b|
      # Calculate the tolerance condition for each element pair
      (val_b - val_a).abs <= tolerance
    end
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
require_relative "tick_registry"

module Tickable
  attr_accessor :args
  
  def enable_tick!
    TickRegistry.register self
  end

  def disable_tick!
    TickRegister.unregister self
  end
end
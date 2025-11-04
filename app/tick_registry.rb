module TickRegistry
  extend self

  def tickables
    @tickables ||= []
  end

  def register entity
    tickables << entity unless tickables.include? entity
  end

  def unregister entity
    tickables.delete entity
  end
end
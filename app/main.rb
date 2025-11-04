require_relative "game"

def tick args
  $game ||= Game.new
  $game.args ||= args
  $game.tick
end
require_relative './original'
require_relative './extend'

def runTetris
  Tetris.new 7
  mainLoop
end

def runTetrisExtend
  TetrisExtend.new
  mainLoop
end

if ARGV.count == 0
  TetrisExtend
elsif ARGV.count != 1
  puts "usage: runner.rb [enhanced | original]"
elsif ARGV[0] == "enhanced"
  TetrisExtend
elsif ARGV[0] == "original"
  runTetris
else
  puts "usage: runner.rb [enhanced | original]"
end

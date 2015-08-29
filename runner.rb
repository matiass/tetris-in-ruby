require_relative './original'
require_relative './extend'

MyTetris.new
  mainLoop
  
=begin
def runTetris
  Tetris.new 7
  mainLoop
end

def runTetrisExtend
  MyTetris.new
  mainLoop
end

if ARGV.count == 0
  runTetrisExtend
elsif ARGV.count != 1
  puts "usage: runner.rb [enhanced | original]"
elsif ARGV[0] == "enhanced"
  runTetrisExtend
elsif ARGV[0] == "original"
  runTetris
else
  puts "usage: runner.rb [enhanced | original]"
end
=end

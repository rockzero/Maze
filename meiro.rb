# めいろを表現する。
class Meiro
  attr_accessor :blocks

  X = 3
  Y = 3

  def initialize
    @blocks = Array.new(X) { Array.new(Y) { Block.new } }
  end

  def generate
    @blocks[0][0].up = false
    @blocks[0][0].down = false
    @blocks[0][1].up = false
    @blocks[0][1].right = false
    @blocks[1][1].left = false
    @blocks[1][1].right = false
    @blocks[2][1].down = false
    @blocks[2][1].left = false
    @blocks[2][2].down = false
    @blocks[2][2].up = false
    @blocks[0][1].down = false
    @blocks[0][2].up = false
    @blocks[0][2].right = false
    @blocks[1][2].left = false
    @blocks[2][1].up = false
    @blocks[2][0].down = false
    @blocks[2][0].left = false
    @blocks[1][0].right = false 
  end

  def show
    Y.times do |y|
      X.times do |x|
        block = @blocks[x][y]
        print "+"
        if block.up
          print "-"
        else
            print " "
        end
        print "+"
      end
      print "\n"
      X.times do |x|
        block = @blocks[x][y]
        if block.left
          print "|"
        else
          print " "
        end
        print " "
        if block.right
          print "|"
        else
          print " "
        end
      end
      print "\n"
      X.times do |x|
        block = @blocks[x][y]
        print "+"
        if block.down
          print "-"
        else
            print " "
        end
        print "+"
      end
      print "\n"
    end
  end
end

# ブロックを表現する。
class Block
  # 上の壁
  attr_accessor :up

  # 下の壁
  attr_accessor :down

  # 左の壁
  attr_accessor :left

  # 右の壁
  attr_accessor :right

  def initialize
    @up = true
    @down = true
    @left = true
    @right = true
  end
end

meiro = Meiro.new
meiro.generate
meiro.show

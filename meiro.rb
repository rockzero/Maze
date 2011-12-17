# めいろを表現する。
class Meiro
  attr_accessor :blocks

  X = 3
  Y = 3

  def initialize
    @blocks = Array.new(X) { Array.new(Y) { Block.new } }
  end

  # 迷路を作る
  def generate(start_x = 0, start_y = 0, goal_x = 2, goal_y = 2)
    # スタートを開ける
    @blocks[start_x][start_y].up = false
    #ゴールを開ける
    @blocks[goal_x][goal_y].down = false

    man_x = start_x
    man_y = start_y
    
    generate_1(man_x, man_y)

=begin
    @blocks[0][0].down = false
    @blocks[0][1].up = false
    @blocks[0][1].right = false
    @blocks[1][1].left = false
    @blocks[1][1].right = false
    @blocks[2][1].down = false
    @blocks[2][1].left = false
    @blocks[2][2].up = false
    @blocks[0][1].down = false
    @blocks[0][2].up = false
    @blocks[0][2].right = false
    @blocks[1][2].left = false
    @blocks[2][1].up = false
    @blocks[2][0].down = false
    @blocks[2][0].left = false
    @blocks[1][0].right = false 
=end
  end

  def generate_1(man_x, man_y)
    block = @blocks[man_x][man_y]

    # 上を見る
    if block.down
    end

    # 右を見る
    if block.right
      # 隣に部屋がある？
      if man_x != 2
        neighbor = @blocks[man_x + 1][man_y]
        if rand(2) == 1
          block.right = false
          neighbor.left = false
          generate_1(man_x + 1, man_y)
        end
      end
    end

    # 左を見る
    if block.left
      # 隣に部屋がある？
      if man_x != 0
        neighbor = @blocks[man_x - 1][man_y]
        if rand(2) == 1
          block.left = false
          neighbor.right = false
          generate_1(man_x - 1, man_y)
        end
      end
    end

    # 下を見る
    if block.down
      if man_y != 2
        neighbor = @blocks[man_x][man_y + 1]
        if block.right == true && block.left == true
          block.down = false
        else
          if rand(2) == 1
            block.down = false
          end
        end
        if !block.down
          neighbor.up = false
          generate_1(man_x, man_y + 1)
        end
      end
    end
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
meiro.generate(rand(3), 0, rand(3), 2)
meiro.show

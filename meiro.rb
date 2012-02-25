# めいろを表現する。
class Meiro
  attr_accessor :blocks

  X = ARGV[1] ? ARGV[1].to_i : 3
  Y = ARGV[0] ? ARGV[0].to_i : 3

  def initialize
    @blocks = Array.new(X) { Array.new(Y) { Block.new } }
  end

  # 迷路を作る
  def generate(start_x = 0, start_y = 0, goal_x = X - 1 , goal_y = Y - 1)
    # スタートを開ける
    @blocks[start_x][start_y].up = false
    #ゴールを開ける
    @blocks[goal_x][goal_y].down = false

    man_x = start_x
    man_y = start_y
    
    generate_1(man_x, man_y, start_x, start_y, goal_x, goal_y)

  end

  def generate_1(man_x, man_y, start_x, start_y, goal_x,goal_y)
    block = @blocks[man_x][man_y]

    block.looked = true

    # 上を見る
    if block.up
      akeru = false
      if man_y != 0
        if rand(2) == 1
          akeru = true
        end
        neighbor = @blocks[man_x][man_y - 1]
        if neighbor.up == true && neighbor.down == true && neighbor.right == true && neighbor.left == true
          akeru = true
        end
        if neighbor.up == true && neighbor.right == true && neighbor.left == true && neighbor == @blocks[goal_x][goal_y]
          akeru = true
        end
        if neighbor.looked
          akeru = false
        end
      end
      if akeru
        # 4つを開けるならばakeruをfalseにする
        neighbor = @blocks[man_x][man_y - 1]
        if man_x != 0 && !block.left
          neighbor_left = @blocks[man_x - 1][man_y - 1]
          if !neighbor_left.right && !neighbor_left.down
            akeru = false
          end
        end
        if man_x != 2 && !block.right
          neighbor_right = @blocks[man_x + 1][man_y - 1]
          if !neighbor_right.left && !neighbor_right.down
            akeru = false
          end
        end
      end
      if akeru
        neighbor = @blocks[man_x][man_y - 1]
        block.up = false
        neighbor.down = false
        generate_1(man_x, man_y - 1, start_x, start_y, goal_x,goal_y)
      end
    end

    # 右を見る
    if block.right
      akeru = false
      if man_x != (X - 1)
        if rand(2) == 1
          akeru = true
        end
        neighbor = @blocks[man_x + 1][man_y]
        if neighbor.up == true && neighbor.down == true && neighbor.right == true && neighbor.left == true
          akeru = true
        end
        if neighbor.up == true && neighbor.right == true && neighbor.left == true && neighbor == @blocks[goal_x][goal_y]
          akeru = true
        end
        if neighbor.looked
          akeru = false
        end
      end
      if akeru
        # 4つを開けるならばakeruをfalseにする
        neighbor = @blocks[man_x + 1][man_y]
        if man_y != 0 && !block.up
          neighbor_up = @blocks[man_x + 1][man_y - 1]
          if !neighbor_up.down && !neighbor_up.left
            akeru = false
          end
        end
        if man_y != (Y - 1) && !block.down
          neighbor_down = @blocks[man_x + 1][man_y + 1]
          if !neighbor_down.up && !neighbor_down.left
            akeru = false
          end
        end
      end
      if akeru
        neighbor = @blocks[man_x + 1][man_y]
        block.right = false
        neighbor.left = false
        generate_1(man_x + 1, man_y, start_x, start_y, goal_x,goal_y)
      end
    end

    # 左を見る
    if block.left
      akeru = false
      if man_x != 0
        if rand(2) == 1
          akeru = true
        end
        neighbor = @blocks[man_x - 1][man_y]
        if neighbor.up == true && neighbor.down == true && neighbor.right == true && neighbor.left == true
          akeru = true
        end
        if neighbor.up == true && neighbor.right == true && neighbor.left == true && neighbor == @blocks[goal_x][goal_y]
          akeru = true
        end
        if neighbor.looked
          akeru = false
        end 
      end
      if akeru
        # 4つを開けるならばakeruをfalseにする
        neighbor = @blocks[man_x - 1][man_y]
        if man_y != 0 && !block.up
          neighbor_up = @blocks[man_x - 1][man_y - 1]
          if !neighbor_up.down && !neighbor_up.right
            akeru = false
          end
        end
        if man_y != (Y - 1) && !block.down
          neighbor_down = @blocks[man_x - 1][man_y + 1]
#puts man_x,man_y
          if !neighbor_down.up && !neighbor_down.right
            akeru = false
          end
        end
      end
      if akeru
        neighbor = @blocks[man_x - 1][man_y]
        block.left = false
        neighbor.right = false
        generate_1(man_x - 1, man_y, start_x, start_y, goal_x,goal_y)
      end
    end


    # 下を見る
    if block.down
      akeru = false
      if man_y != (Y - 1)
        if rand(2) == 1
          akeru = true
        end
        neighbor = @blocks[man_x][man_y + 1]
        if neighbor.up == true && neighbor.down == true && neighbor.right == true && neighbor.left == true
          akeru = true
        end
        if @blocks[man_x][man_y].up && @blocks[man_x][man_y].right && @blocks[man_x][man_y].left
          akeru = true
        end
        if neighbor.looked
          akeru = false
        end
      end
      if akeru
        # 4つを開けるならばakeruをfalseにする
        neighbor = @blocks[man_x][man_y + 1]
        if man_x != 0 && !block.left
          neighbor_left = @blocks[man_x - 1][man_y + 1]
          if !neighbor_left.up && !neighbor_left.right
            akeru = false
          end
        end
        if man_x != (X - 1) && !block.right
          neighbor_right = @blocks[man_x + 1][man_y + 1]
          if !neighbor_right.up && !neighbor_right.left
            akeru = false
          end
        end
      end
      if akeru
        neighbor = @blocks[man_x][man_y + 1]
        block.down = false
        neighbor.up = false
        generate_1(man_x, man_y + 1, start_x, start_y, goal_x,goal_y)
      end
    end
  end

  def show
    Y.times do |y|
      X.times do |x|
        block = @blocks[x][y]
        print "＋"
        if block.up
          print "ー"
        else
            print "　"
        end
        print "＋"
      end
      print "\n"
      X.times do |x|
        block = @blocks[x][y]
        if block.left
          print "｜"
        else
          print "　"
        end
        print "　"
        if block.right
          print "｜"
        else
          print "　"
        end
      end
      print "\n"
      X.times do |x|
        block = @blocks[x][y]
        print "＋"
        if block.down
          print "ー"
        else
            print "　"
        end
        print "＋"
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

  # 見たブロック
  attr_accessor :looked

  def initialize
    @up = true
    @down = true
    @left = true
    @right = true
    @looked = false
  end
end

meiro = Meiro.new
meiro.generate(rand(Meiro::X), 0, rand(Meiro::X), Meiro::Y - 1)
meiro.show

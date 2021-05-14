class RobotMovement
  attr_accessor :facing, :x, :y, :commands
  VALID_COMMANDS = ['MOVE', 'LEFT', 'RIGHT', 'REPORT']
  VALID_FACINGS = ['NORTH', 'SOUTH', 'EAST', 'WEST']
  def initialize(x, y, facing, commands)
    @x = x.to_i
    @y = y.to_i
    @facing = facing
    @commands = commands
  end

  def valid?
    x.between?(0, 4) && y.between?(0,4) &&
    VALID_FACINGS.include?(facing) && (commands - VALID_COMMANDS).blank?
  end

  def execute_commands
    commands.each do |cmd|
     move if cmd == 'MOVE'
      update_facing(cmd) if ['LEFT', 'RIGHT'].include?(cmd)
    end
  end

  def location
    { location: [x,y,facing] }
  end

  def update_facing(direction)
    if direction == 'LEFT'
      new_facing = 'WEST' if facing == 'NORTH'
      new_facing = 'EAST' if facing == 'SOUTH'
      new_facing = 'NORTH' if facing == 'EAST'
      new_facing = 'SOUTH' if facing == 'WEST'
    else
      new_facing = 'EAST' if  facing == 'NORTH'
      new_facing = 'WEST' if  facing == 'SOUTH'
      new_facing = 'SOUTH' if facing == 'EAST'
      new_facing = 'NORTH' if facing == 'WEST'
    end
    @facing = new_facing
  end

  def move
    @y=y+1 if facing == 'NORTH' && y < 4
    @y=y-1 if facing == 'SOUTH' && y > 0
    @x=x+1 if facing == 'EAST' && y < 4
    @x=x-1 if facing == 'WEST' && y > 0
  end
end

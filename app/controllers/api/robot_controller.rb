class Api::RobotController < ApplicationController
  def orders
    commands = params['commands']
    placement_params = parse_placement_params(commands[0])
    obj = RobotMovement.new(*placement_params, commands[1..-1])    
    if obj.valid?
      obj.execute_commands
      render :json => obj.location, status: :ok
    else
      render :json => {mesage: 'command params is wrong'}, :status => 400
    end    
  end

  def parse_placement_params(initial_placement)
    initial_placement.split(' ').last.split(',')
  end
end


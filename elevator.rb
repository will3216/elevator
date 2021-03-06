
class Elevator
  attr_reader :floors, :floor, :queue, :status

  def initialize(floor_list, current_floor)
    @queue = floor_list.map { |floor| 0 }
    @floors = floor_list
    @floor = current_floor
    @status = 'idle'
  end
  
  def current_floor
    @floors[@floor]
  end
  
  def directions_in_queue
    stops = [0,0]
    @queue.each_index do |i| 
      stops[0] = 1 if @queue[i] == 1 and i < @floor
      stops[1] = 1 if @queue[i] == 1 and i > @floor
    end
    stops
  end
  
  def update_status
    stops = self.directions_in_queue()
    @status = 'idle' if stops[0] == 0 and stops[1] == 0
    @status = 'up'   if (stops[0] == 0 or @status == 'up') and stops[1] == 1
    @status = 'down' if (stops[1] == 0 or @status == 'down') and stops[0] == 1
    @status
  end
  
  def push_button(floor)
    @queue[floor] = 1 if not floor == @floor
    self.update_status()
    @queue
  end
  
  def move_floor(displacement)
    @floor += displacement
    @queue[@floor] = 0
    self.update_status
  end
  
  def up
    self.move_floor(1)
  end
  
  def down
    self.move_floor(-1)
  end
  
  def idle
    "nothing happens"
    self.update_status
  end
  
  def move
    self.send(@status)
    @floors[@floor]
  end
end

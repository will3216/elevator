require 'spec_helper'

describe Elevator do
  before :each do
    @elevator = Elevator.new ['B','1','2','3','4','5','6','7'], 1
  end
  
  subject { @elevator }
  
  it { should respond_to(:floors) }
  it { should respond_to(:floor) }
  it { should respond_to(:queue) }
  it { should respond_to(:status) }
  
  describe "#new" do
    it "takes a list of floors with an index and returns an Elevator object" do
      @elevator.should be_an_instance_of Elevator
    end
  end
  
  describe "#current_floor" do
    it "should return the current floor of the elevator" do
      @elevator.current_floor.should eql '1'
    end
  end
    
  describe "#directions_in_queue" do
    it "should return a list whose entries correspond to up and down" do
      @elevator.directions_in_queue.should eql [0,0]
    end
  end
  
  describe "#update_status" do
    it "should determine the status of the elevator" do
      @elevator.update_status.should eql 'idle'
    end
  end
  
  describe "#move" do
    it "should move the elevator in the direction its status indicates" do
      @elevator.move.should eql '1'
    end
  end
  
  describe "#push_button" do
    it "should add a floor to the queue before returning it" do
      @elevator.push_button(3).should eql [0,0,0,1,0,0,0,0]
    end
  end
  
  describe "#update_status" do
    it "status should be idle if no buttons have been pressed" do
      @elevator.queue.should eql [0,0,0,0,0,0,0,0]
      @elevator.update_status.should eql 'idle'
    end
    
    it "should change the status to up when elevator is idle and a floor is pressed above it" do
      @elevator.instance_variable_set(:@queue, [0,0,0,1,0,0,0,0])
      @elevator.instance_variable_set(:@floor, 1)
      @elevator.update_status.should eql 'up'
    end
    
    it "should change the status to down when elevator is idle and a floor is pressed below it" do
      @elevator.instance_variable_set(:@status, 'idle')
      @elevator.instance_variable_set(:@queue, [0,0,0,1,0,0,0,0])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should eql 'down'
    end
    
    it "should not change the status from up if there are floors above the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'up')
      @elevator.instance_variable_set(:@queue, [0,0,0,1,0,0,0,1])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should eql 'up'
    end
    
    it "should not change the status from down if there are floors below the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'down')
      @elevator.instance_variable_set(:@queue, [0,0,0,1,0,0,0,1])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should eql 'down'
    end
    
    it "should change the status from down if there are no floors below the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'down')
      @elevator.instance_variable_set(:@queue, [0,0,0,0,0,0,0,1])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should_not eql 'down'
      @elevator.status.should eql 'up'
    end
    
    it "should change the status from down if there are no floors below the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'down')
      @elevator.instance_variable_set(:@queue, [0,0,0,0,0,0,0,0])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should_not eql 'down'
      @elevator.status.should eql 'idle'
    end
    
    it "should change the status from up if there are no floors above the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'up')
      @elevator.instance_variable_set(:@queue, [0,0,0,0,0,0,0,0])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should_not eql 'up'
      @elevator.status.should eql 'idle'
    end
    
    it "should change the status from up if there are no floors above the elevator in the queue" do
      @elevator.instance_variable_set(:@status, 'up')
      @elevator.instance_variable_set(:@queue, [1,0,0,0,0,0,0,0])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.update_status.should_not eql 'up'
      @elevator.status.should eql 'down'
    end
  end
  
  describe "#move" do
    it "should move the elevator in the direction its status indicates" do
      @elevator.instance_variable_set(:@status, 'down')
      @elevator.instance_variable_set(:@queue, [0,0,0,1,0,0,0,1])
      @elevator.instance_variable_set(:@floor, 5)
      @elevator.move.should eql '4'
      @elevator.move.should eql '3'
      @elevator.queue.should eql [0,0,0,0,0,0,0,1]
      @elevator.move.should eql '4'
      @elevator.move.should eql '5'
      @elevator.move.should eql '6'
      @elevator.move.should eql '7'
      @elevator.move.should eql '7'
    end
  end
end

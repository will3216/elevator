require 'spec_helper'

describe Elevator do
  before :all do
    @elevator = Elevator.new ['B','1','2','3','4','5','6','7'], 1
  end
  
  describe "#new" do
    it "takes a list of floors with an index and returns an Elevator object" do
      @elevator.should be_an_instance_of Elevator
    end
  end
  
  describe "#floors" do
    it "should return the list of floors passed in on creation of the object" do
      @elevator.floors.should eql ['B','1','2','3','4','5','6','7']
    end
  end
  
  describe "#floor" do
    it "should return the current floor of the elevator" do
      @elevator.floor.should eql 1
    end
  end
  
  describe "#queue" do
    it "should return the queue for this elevator" do
      @elevator.queue.should eql [0, 0, 0, 0, 0, 0, 0, 0]
    end
  end
  
  describe "#current_floor" do
    it "should return the current floor of the elevator" do
      @elevator.current_floor.should eql '1'
    end
  end
  
  describe "#status" do
    it "should get and return the status for this elevator" do
      @elevator.status.should eql 'idle'
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
    it "should have changed the status when the button was pushed" do
      @elevator.status.should eql 'up'
    end
  end
  
  describe "#move" do
    it "should move the elevator in the direction its status indicates" do
      @elevator.move.should eql '2'
      @elevator.move.should eql '3'
      @elevator.move.should eql '3'
    end
  end
end
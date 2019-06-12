require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should change complete attribute to false if it began as true' do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
    
    it 'should change complete attribute to true if it began as false' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should change favorite attribute to false if it began as true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should change favorite attribute to true if it began as false' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    # it 'should return true if current time is past the deadline' do
    #   task = Task.new(deadline: "2012-05-30")
    #   expect(task.overdue?).to eq(true)
    # end


    # it 'should return false if the current time is before the deadline' do
    #   task = Task.new(deadline: 1.hour.)
    #   expect(task.overdue?).to eq(false)
    # end

    it 'should return true if current time is past the deadline' do
      task = Task.new(deadline: 1.hour.ago)
      expect(task.overdue?).to eq(true)
    end

    it 'should return true if current time is past the deadline' do
      task = Task.new(deadline: 1.hour.from_now)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should return the value of priority + 1 if the initial priority is < 10' do
      task = Task.new(priority: 2)
      task.increment_priority!
      expect(task.priority).to eq(3)
    end

    it 'should return the value of priority + 1 if the initial priority is < 10' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    # it 'should return the value of priority - 1' do
    #   task = Task.new(priority: 2)
    #   task.decrement_priority!
    #   expect(task.priority).to eq(1)
    # end

    it 'should return the value of priority - 1 if the initial priority is > 1' do
      task = Task.new(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should return the value of priority - 1 if the initial priority is < 10' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    # it 'should return the datetime of deadline plus 1 hour' do
    #   task = Task.new(deadline: '2020-4-15 23:00')
    #   task.snooze_hour!
    #   expect(task.deadline).to eq('2020-4-16')
    # end

    # it 'should return the datetime of deadline plus 1 hour' do
    #   task = Task.new(deadline: '2020-4-15 23:10')
    #   task.snooze_hour!
    #   expect(task.deadline).to eq('2020-4-16 0:10')
    # end

    it 'should return the datetime of deadline plus 1 hour' do
      time = Time.now
      task = Task.new(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end
end

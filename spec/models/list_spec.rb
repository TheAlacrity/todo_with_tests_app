require 'rails_helper'

RSpec.describe List, type: :model do

  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "My Favorite Things To Do")
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)

      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should add one hour to the deadline of all tasks' do 
      list = List.create(name: "Test List")
      time = Time.now
      Task.create(deadline: time, list_id: list.id)
      Task.create(deadline: time, list_id: list.id)

      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(time + 1.hour)  
      end
    end  
  end

  describe '#total_duration' do 
    it 'should return the sum durations for all tasks' do
      list = List.create
      Task.create(duration: 10, list_id: list.id)
      Task.create(duration: 10, list_id: list.id)

      expect(list.total_duration).to eq(20)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of tasks where complete is equal to false' do
      list = List.create
      task_1 = Task.create(complete: false, list_id: list.id)
      task_2 = Task.create(complete: false, list_id: list.id)
      task_3 = Task.create(complete: true, list_id: list.id)

      tasks_array = [task_1, task_2]

      expect(list.incomplete_tasks.length).to eq(2)
      expect(list.incomplete_tasks).to eq(tasks_array)
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of tasks where favorite is equal to true' do
      list = List.create
      task_1 = Task.create(favorite: true, list_id: list.id)
      task_2 = Task.create(favorite: true, list_id: list.id)
      task_3 = Task.create(favorite: false, list_id: list.id)

      tasks_array = [task_1, task_2]

      expect(list.favorite_tasks.length).to eq(2)
      expect(list.favorite_tasks).to eq(tasks_array)
    end
  end
end

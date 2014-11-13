class Task
  attr_reader :name, :completed

  def initialize(name)
    @name = name
    @completed = false
  end

  def edit_task(new_name)
    @name = new_name
  end

  def complete
    @completed = true
  end

end

class Project
  attr_reader :name, :tasks

  def initialize (name)
    @name = name
    @tasks = []
  end

  def rename(new_name)
    @name = new_name
  end

  def add_task(task)
    @tasks << task
  end

end

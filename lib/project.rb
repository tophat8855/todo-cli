class Project
  attr_reader :name, :tasks

  def initialize (name)
    @name = name
    @tasks = []
  end

  def rename(new_name)
    @name = new_name
  end

  # def list_tasks
  #   if @tasks.empty?
  #     puts "Tasks:\n  none"
  #   else
  #     puts "Tasks:\n"
  #     @tasks.each {|task| puts "  " + task.name.to_s}
  #   end
  # end

  def add_task(task)
    @tasks << task
  end

end

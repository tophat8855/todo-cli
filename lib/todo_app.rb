class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
  end

  def real_puts message=""
    $stdout.puts message
  end

  def run
    puts "Welcome to the TodoApp"
    running = true
    project_menu

    while running
      user_input = gets.chomp

      case user_input
      when 'list'
        list
      when 'create'
        create
      when 'rename'
        rename
      when 'delete'
        delete
      when 'edit'
        editing = true
        puts "Please enter the project name to edit:\n"
        project_to_edit = gets.chomp
        edit_menu(project_to_edit)

        while editing
          user_input = gets.chomp

          case user_input
          when 'list'
            list_tasks(project_to_edit)
          when 'create'
            create_task(project_to_edit)
          when 'delete'
            delete
          when 'edit'
            edit_task(project_to_edit)
          when 'complete'
            complete(project_to_edit)
          when 'back'
            editing = false
            project_menu
          when 'quit'
            editing = false
            running = false
          end
        end

      when 'quit'
        running = false
      end

    end

  end

  def project_menu
    puts "Type 'list' to list projects"
    puts "Type 'create' to create a new project"
    puts "Type 'edit' to edit a project"
    puts "Type 'rename' to rename a project"
    puts "Type 'delete' to delete a project"
    puts "Type 'quit' to exit programme"
  end

  def edit_menu(edit_this)
    puts "Editing Project: #{edit_this}"
    puts "Type 'list' to list tasks"
    puts "Type 'create' to create a new task"
    puts "Type 'edit' to edit a task"
    puts "Type 'complete' to complete a task and remove it from the list"
  end

  def list
    if @projects.empty?
      puts "Projects:\n  none"
    else
      list = @projects.map do |project|
        project.name
      end
      puts "Projects:\n  #{list.join(" ")}"
    end
  end

  def create
    puts "Please enter the new project name:\n"
    new_project = gets.chomp
    @projects << Project.new(new_project)
  end

  def rename ## want to come in here and add a check for valid project name?
    puts "Please enter the project name to rename:\n"
    old_name = gets.chomp
    puts "Please enter the new project name:\n"
    new_name = gets.chomp
    project = @projects.detect {|project| project.name == old_name}
    project.rename(new_name)
  end

  def delete ## want to check for valid project name?
    puts "Please enter the project name to delete:\n"
    project_to_delete = gets.chomp
    project = @projects.detect {|project| project.name == project_to_delete}
    @projects.delete(project)
  end

  def list_tasks(project_name)
    project = @projects.detect {|project| project.name == project_name}
    if project.tasks.empty?
      puts "Tasks:\n  none"
    else
      puts "Tasks:\n"
      project.tasks.each {|task| puts "  " + task.name.to_s}
    end
  end

  def create_task(project_name)
    puts "Please enter the new task name:\n"
    new_task_name = gets.chomp
    project = @projects.detect {|project| project.name == project_name}
    project.add_task(Task.new(new_task_name))
  end

  def edit_task(project_name)
    puts "Please enter which task to edit:\n"
    task_to_edit = gets.chomp
    project = @projects.detect {|project| project.name == project_name}
    task = project.tasks.detect {|task| task.name == task_to_edit}
    if task == nil
      puts "task not found: '#{task_to_edit}'"
    else
      puts "Please enter new task name:\n"
      new_task_name = gets.chomp
      task.edit_task(new_task_name)
      puts "Task renamed to #{new_task_name}"
    end
  end

  def complete(project_name)
    project = @projects.detect {|project| project.name == project_name}
    puts "Please enter the task to mark 'complete'"
    completed_task = gets.chomp

    task = project.tasks.detect {|task| task.name == completed_task}
    if task == nil
      puts "task not found: '#{completed_task}'"
    else
      task.complete
      puts task.name + ": completed"
    end
  end
end

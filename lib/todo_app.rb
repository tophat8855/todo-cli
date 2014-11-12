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
    puts "Type 'list' to list projects"
    puts "Type 'create' to create a new project"
    puts "Type 'edit' to edit a project"
    puts "Type 'delete' to delete a project"
    puts "Type 'rename' to rename a project"
    puts "Type 'quit' to exit programme"
    running = true

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
          puts "Editing Project: #{project_to_edit}"
          puts "Type 'list' to list tasks"
          puts "Type 'create' to create a new task"
          puts "Type 'edit' to edit a task"
          puts "Type 'complete' to complete a task and remove it from the list"

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
            puts "Type 'list' to list projects"
            puts "Type 'create' to create a new project"
            puts "Type 'edit' to edit a project"
            puts "Type 'delete' to delete a project"
            puts "Type 'rename' to rename a project"
            puts "Type 'quit' to exit programme"
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

  def rename ## want to come in here and add a check for valid project name ##
    puts "Please enter the project name to rename:\n"
    old_name = gets.chomp
    puts "Please enter the new project name:\n"
    new_name = gets.chomp
    @projects.each do |project|
      if project.name == old_name
        project.rename(new_name)
      end
    end
  end

  def delete ## want to check for valid project name?
    puts "Please enter the project name to delete:\n"
    project_to_delete = gets.chomp

    @projects.each do |project|
      if project.name == project_to_delete
        @projects.delete(project)
      end
    end
  end

  def list_tasks(project_title)
    @projects.each do |project|
      if project.name == project_title
        if project.tasks.empty?
          puts "Tasks:\n  none"
        else
          puts "Tasks:\n"
          project.tasks.each do |task|
            puts "  " + task.name.to_s
          end
        end
      end

    end
  end

  def create_task(project_name)
    puts "Please enter the new task name:\n"
    new_task_name = gets.chomp
    @projects.each do |project|
      if project.name == project_name
        project.add_task(Task.new(project_name, new_task_name))
      end
    end
  end

  def edit_task(project_name)
    puts "Please enter which task to edit:\n"
    task_to_edit = gets.chomp
    @projects.each do |project|
      if project.name == project_name
        is_it_a_legit_task = []

        project.tasks.each do |task|
          if task_to_edit == task.name
            is_it_a_legit_task << true
            puts "Please enter new task name:\n"
            new_task_name = gets.chomp
            task.edit_task(new_task_name)
            puts "Task renamed to #{new_task_name}"
          else
            is_it_a_legit_task << false
          end

        end
        unless is_it_a_legit_task.include?(true)
          puts "task not found: '#{task_to_edit}'"
        end
      end
    end

    def complete(project_name)
      @projects.each do |project|
        if project.name == project_name
          is_it_a_legit_task = []
          puts "Please enter the task to mark 'complete'"
          completed_task = gets.chomp
          project.tasks.each do |task|
            if completed_task == task.name
              is_it_a_legit_task << true
              task.complete
              puts task.name + ": completed"
            else
              is_it_a_legit_task << false
            end
          end
          unless is_it_a_legit_task.include?(true)
            puts "task not found: '#{completed_task}'"
          end

        end
      end
    end

  end

end

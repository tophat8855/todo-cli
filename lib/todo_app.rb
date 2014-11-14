class TodoApp < CommandLineApp
  attr_reader :output, :input, :model

  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @view = View.new(output)
  end

  def real_puts message=""
    $stdout.puts message
  end

  def get_input
    gets.chomp
  end

  def run
    welcome
    running = true
    print_project_menu

    while running
      user_input = get_input

      case user_input
      when 'list'
        print_project_list
      when 'create'
        print_create_project_prompt
        new_project = get_input
        create_project(new_project)
      when 'rename'
        print_old_name_prompt
        old_name = get_input
        print_new_name_prompt
        new_name = get_input
        rename_project(old_name, new_name)
      when 'delete'
        print_delete_project_prompt
        delete
      when 'edit'
        editing = true
        print_project_to_edit_prompt
        project_to_edit = get_input
        print_edit_menu(project_to_edit)

        while editing
          user_input = get_input

          case user_input
          when 'list'
            list_tasks(project_to_edit)
          when 'create'
            print_create_task_prompt
            create_task(project_to_edit)
          when 'delete'
            delete
          when 'edit'
            edit_task_prompt
            edit_task(project_to_edit)
          when 'complete'
            complete(project_to_edit)
          when 'back'
            editing = false
            print_project_menu
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

  def welcome
    puts "Welcome to the TodoApp"
  end

  def print_project_menu
    @view.print_project_menu
  end

  def print_edit_menu(edit_this_project)
    @view.print_edit_menu(edit_this_project)
  end

  def print_project_to_edit_prompt
    @view.print_project_to_edit_prompt
  end

  def print_project_list
    if @projects.empty?
      puts "Projects:\n  none"
    else
      list = @projects.map do |project|
        project.name
      end
      puts "Projects:\n  #{list.join(" ")}"
    end
  end

  def print_create_project_prompt
    @view.print_create_project_prompt
  end

  def print_old_name_prompt
    @view.print_old_name_prompt
  end

  def print_new_name_prompt
    @view.print_new_name_prompt
  end

  def print_delete_project_prompt
    @view.print_delete_project_prompt
  end

  def print_create_task_prompt
    @view.print_create_task_prompt
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

  def edit_task_prompt
    @view.edit_task_prompt
  end

  def create_project(new_project)
    @projects << Project.new(new_project)
  end

  def rename_project(old_name, new_name) ## want to come in here and add a check for valid project name?
    project = @projects.detect {|project| project.name == old_name}
    project.rename(new_name)
  end

  def delete ## want to check for valid project name?
    project_to_delete = get_input
    project = @projects.detect {|project| project.name == project_to_delete}
    @projects.delete(project)
  end

  def create_task(project_name)
    new_task_name = get_input
    project = @projects.detect {|project| project.name == project_name}
    project.add_task(Task.new(new_task_name))
  end

  def edit_task(project_name)
    task_to_edit = get_input
    project = @projects.detect {|project| project.name == project_name}
    task = project.tasks.detect {|task| task.name == task_to_edit}
    if task == nil
      puts "task not found: '#{task_to_edit}'"
    else
      puts "Please enter new task name:\n"
      new_task_name = get_input
      task.edit_task(new_task_name)
      puts "Task renamed to #{new_task_name}"
    end
  end

  def complete(project_name)
    project = @projects.detect {|project| project.name == project_name}
    puts "Please enter the task to mark 'complete'"
    completed_task = get_input

    task = project.tasks.detect {|task| task.name == completed_task}
    if task == nil
      puts "task not found: '#{completed_task}'"
    else
      task.complete
      puts task.name + ": completed"
    end

  end
end

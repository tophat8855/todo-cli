class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
    @projects = []
    @tasks = []
  end

  def real_puts message=""
    $stdout.puts message
  end

  def run
    puts "Welcome to the TodoApp"
    puts "Type 'list' to list projects"
    puts "Type 'create' to create a new project"
    puts "Type 'edit' to edit a project"
    puts "Type 'delete' to edit a project"
    puts "Type 'rename' to rename a project"

    user_input = gets.chomp

    while user_input != "quit"

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
        edit
      when 'back'
        run
      end

      user_input = gets.chomp
    end

  end

  def list
    if @projects.empty?
      puts "Projects:\n  none"
    else
      puts "Projects:\n  #{@projects.join}"
    end
  end

  def create
    puts "Please enter the new project name:\n"
    new_project = gets.chomp
    @projects << new_project
    puts "Projects:\n  #{new_project}"
  end

  def rename
    puts "Please enter the project name to rename:\n"
    old_name = gets.chomp

    if @projects.include?(old_name)
      @projects.delete(old_name)
      puts "Please enter the new project name:\n"
      new_name = gets.chomp
      @projects << new_name
    else
      puts "not a valid project name"
    end
  end

  def delete
    puts "Please enter the project name to delete:\n"
    project_to_delete = gets.chomp
    if @projects.include?(project_to_delete)
      @projects.delete(project_to_delete)
    else
      puts "not a valid project name"
    end
  end

  def edit
    puts "Please enter the project name to edit:\n"
    project_to_edit = gets.chomp
    if @projects.include?(project_to_edit)
      puts "Editing Project: #{project_to_edit}"
      puts "Type 'list' to list tasks"
      puts "Type 'create' to create a new task"
      puts "Type 'edit' to edit a task"
      puts "Type 'complete' to complete a task and remove it from the list"
    else
      puts "not a valid project name"
    end
  end

end

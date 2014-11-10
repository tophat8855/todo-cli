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
    puts "Type 'delete' to edit a project"

    user_input = gets.chomp

    while user_input != "quit"

      if user_input == 'list'
        list
      elsif user_input == 'create'
        create
      elsif user_input == 'edit'
        edit
      elsif user_input == 'delete'
        delete
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

  def edit
    puts "Please enter the project name to edit:\n"
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

end

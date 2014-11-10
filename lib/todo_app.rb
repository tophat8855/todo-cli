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

    user_input = gets.chomp

    while user_input != "quit"

      if user_input == 'list'
        list
      elsif user_input == 'create'
        create(gets.chomp)
      end
      user_input = gets.chomp

    end

  end

  def list
    if @projects.empty?
      puts "Projects:\n  none"
    end

  end

  def create(new_project)
    @projects << new_project
    puts "Projects:\n  #{new_project}"
  end

end

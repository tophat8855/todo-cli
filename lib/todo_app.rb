class TodoApp < CommandLineApp
  def initialize(input, output)
    @input = input
    @output = output
  end

  def real_puts message=""
    $stdout.puts message
  end

  def run
    puts "Welcome to the TodoApp"
    puts "Type 'list' to list projects"
    puts "Type 'create' to create a new project"
    puts "Type 'edit' to edit a project"

    while gets.chomp != "quit"
      
    end
  end

end

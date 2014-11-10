require_relative "./lib/command_line_app"
require_relative "./lib/todo_app"

TodoApp.new($stdin, $stdout).run

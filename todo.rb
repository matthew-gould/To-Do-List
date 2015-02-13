require "pry"
require "./db/setup"
require "./lib/all"
require "colorize"

puts "*****RUNNING TO-DO LIST*****"
sleep(1)
puts "\n===========================\n==========================="


def add (list, item)
# This will add a list and item unless no item is specified in which case it will only add a list.
  List.find_or_create_by(name: list)
  List.find_by(name: list).items.create(item_name: item)

  end

def due (item, due_date)
# This will add a due date for an already created item.
  a = Item.find_by(id: item)
  a.update(due_date: due_date)
  end

def done (item)
# Marks the given item as completed.
   Item.find_by(id: item).update(completed: true)
end

def list name=nil
# If no list name is given, show all incomplete items. If name is given, show only items from the given list.
  if name != nil
    a = List.find_by(name: name).items
    a.find_each do |item|
      if item.completed = true
        puts "#{item.item_name}".colorize(:green)
      else
        puts "#{item.item_name}".colorize(:red)
    end
  end
  else
    a = Item.find_by(completed: false)
    
  end
end

def list_all
# Show all lists/items with visual cue for completed items.
  
    # if Item.find_by(completed: true)
    #   .colorize(:green)
    # else .colorize(:red)
    # end
end

def next
# Picks a random item with preference for items with due dates.
end

def search (string)
# Searched lists/items for a specific string.
end


command = ARGV.shift
case command
when "add"
  # adds TODO item to list (or creates a new list)
  list = ARGV.first
  item = ARGV[1]

  add(list, item)
end
case command
when "due"
  # adds a due date to the associated item.
  item = ARGV.first
  due_date = ARGV[1]

  due(item, due_date)
end
case command
when "done"
  item = ARGV.first

  done(item)
end
case command
when "list"
  name = ARGV.first

  list(name)
end


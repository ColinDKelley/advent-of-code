# current working directory, ending in /
@cwd = "/"
# collection of dirs (if ending in /) or files pointing to their size
# dirs initially point to 0 and are summed later
@tree = { "/" => 0 }

# returns the parent directory ending in /
def parent_dir(path)
  path.sub(/[^\/]*\/?$/, "")
end

def cd(dir)
  case dir
  when "/"
    @cwd = dir
  when /^\//
    @cwd = "#{dir}/"
  when ".."
    @cwd = parent_dir(@cwd)
  else
    @cwd = "#{@cwd}#{dir}/"
  end
end

def process_command(command)
  case command
  when /^cd (.*)/
    dir = Regexp.last_match.captures.first
    cd(dir)
  when /^ls$/
  else
    raise "unknown command #{line}"
  end
end

def process_ls_output(line)
  case line
  when /^dir (.*)/
    dir = Regexp.last_match.captures.first
    @tree["#{@cwd}#{dir}/"] = 0
  when /^(\d+) (.*)/
    size, filename = Regexp.last_match.captures
    @tree["#{@cwd}#{filename}"] = size.to_i
  else
    raise "unknown output #{line}"
  end
end

STDIN.each_line do |line|
  if line.start_with?("$ ")
    process_command(line[2..-1])
  else
    process_ls_output(line)
  end
end

# if any paths are missing, fill them in with size 0
@tree.keys.each do |path|
  dir = path
  while dir != "/"
    @tree[dir] ||= 0
    dir = parent_dir(dir)
  end
end

def sum_tree(dir)
  @tree.each do |path, size|
    if parent_dir(path) == dir
      @tree[dir] +=
        if path.end_with?("/")
          sum_tree(path)
        else
          size
        end
    end
  end
  @tree[dir]
end

# sum all the directory sizes
sum_tree("/")

used = @tree["/"]
free = 70_000_000 - used
need_to_free = 30_000_000 - free

puts "used: #{used}; free: #{free}; need_to_free: #{need_to_free}"

puts @tree.select { |path, size| path.end_with?("/") && size >= need_to_free }.map(&:last).min

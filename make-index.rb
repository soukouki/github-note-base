
require 'yaml'

target_dir = ARGV[0]

indexes = YAML.load_file('tmp/indexes.yaml')

files = indexes[:files]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}
  .map{|hash|"- [#{hash[:title]}](#{hash[:name]}.html)"}

dirs = indexes[:dirs]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}
  .delete_if{|hash|hash[:path] == target_dir}
  .map{|hash|"- [#{hash[:title]}/](#{hash[:path]}/index.html)"}

if File.dirname(target_dir) != '.'
  updir = {
    path: File.dirname(target_dir),
    title: File.basename(target_dir),
  }
end

puts <<~MD
  #{indexes[:dirs].find{|h|h[:path] == target_dir}[:title]}
  =====

  Dirs
  -----
  #{dirs.join("\n")}
  
  Files
  -----
  #{files.join("\n")}

  #{
    if updir
      "up: [#{updir[:title]}](../index.html)"
    end
  }
MD

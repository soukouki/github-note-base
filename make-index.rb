
require 'yaml'

target_dir = ARGV[0]

index = YAML.load_file('tmp/index.yaml')

files = index[:files]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}
  .map{|hash|"- [#{hash[:title]}](#{hash[:name]}.html)"}

dirs = index[:dirs]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}
  .delete_if{|hash|hash[:path] == target_dir}
  .map{|hash|"- [#{hash[:title]}/](#{hash[:path]}/index.html)"}

if target_dir != '.'
  updir_path = index[:dirs].find{|h|h[:path] == target_dir}[:dir]
  updir = index[:dirs].find{|h|h[:path] == updir_path}
end

puts <<~MD
  #{index[:dirs].find{|h|h[:path] == target_dir}[:title]} の目次
  =====

  #{
    unless dirs.empty?
      <<~DIRS
        フォルダ
        -----
        #{dirs.join("\n")}
      DIRS
    end
  }
  
  #{
    unless files.empty?
      <<~FILES
        メモ
        -----
        #{files.join("\n")}
      FILES
    end
  }

  #{
    if updir
      <<~UP
        親フォルダの目次
        -----
        [#{updir[:title]}](../index.html)
      UP
    end
  }
MD

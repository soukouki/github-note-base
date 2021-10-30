
require 'yaml'

target_file = ARGV[0]

index = YAML.load_file('tmp/index.yaml')

source = open("src/#{target_file}.md", 'r'){|io|io.read}

files_in_same_dir = index[:files]
  .select{|h|h[:dir] == File.dirname(target_file)}
  .sort_by{|h|h[:path]}

index_in_same_dir = files_in_same_dir.find_index{|p|p[:path] == target_file}
source += <<~MD


  ---
  #{
    if index_in_same_dir != 0
      pre = files_in_same_dir[index_in_same_dir-1]
      "前のページ: [#{pre[:title]}](#{pre[:name]}.html)\n"
    end
  }
  #{
    if index_in_same_dir != files_in_same_dir.length-1
      nex = files_in_same_dir[index_in_same_dir+1]
      "次のページ: [#{nex[:title]}](#{nex[:name]}.html)\n"
    end
  }
  目次: [#{index[:dirs].find{|h|h[:path] == File.dirname(target_file)}[:title]}](index.html)
MD

puts source.gsub(/\[(.+?)\](?!\()/){|origin_text|
  link_text = $1
  link = index[:files].find{|h|h[:title] == link_text}
  if link
    "[#{link[:title]}](#{'../'*target_file.count('/')}#{link[:path]}.html)"
  else
    origin_text
  end
}
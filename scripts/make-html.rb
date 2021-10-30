
require 'kramdown'

require './scripts/utility'

target_file = ARGV[0]

root_dir_path = root_dir_path(target_file)

text = open(target_file, 'r'){|io|io.read}

title = text.lines.first.chomp.sub(/^#\s+/, '')

body = Kramdown::Document.new(text).to_html

html_base = open('base.html', 'r').read

puts html_base.gsub(/\{\{(.+)\}\}/){eval($1)}

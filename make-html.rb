
require 'kramdown'

text = open(ARGV[0], 'r').read

title = text.lines.first.chomp.sub(/^#\s+/, '')

body = Kramdown::Document.new(text).to_html

html_base = open('base.html', 'r').read

puts html_base.gsub(/\{\{(.+)\}\}/){eval($1)}

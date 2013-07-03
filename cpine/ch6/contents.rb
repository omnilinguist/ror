# titles,pages should have same length
titles = ['Getting Started', 'Numbers', 'Letters', 'Variables and Assignment', 'Mixing It Up', 'More About Methods', 'Flow Control', 'Arrays and Iterators', 'Writing Your Own Methods', 'There\'s Nothing New to Learn in Chapter 10']
pages = [1, 9, 13, 17, 21, 27, 37, 51, 57, 69]

n = titles.length
line_width = 80
rcol_len = 12
puts "Table of Contents".center(line_width)
(0...n).each{ |i| puts ("Chapter " + (i+1).to_s.rjust(n.to_s.length) + ":  " + titles[i]).ljust(line_width - rcol_len) + ("page " + pages[i].to_s.rjust(pages.max.to_s.length)).rjust(rcol_len)}

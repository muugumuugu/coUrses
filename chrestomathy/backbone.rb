print ("Hlo\n")
=begin
everything is an object in ruby
interpreted lang, line-by-line formated
very similar to py
=end

# variable to be declared beginning with lowercase letter
# declaring a constant is --> name it with caps. :O
#------------------------------

=begin

print "Enter A value: "
first_num=gets.to_f
print "Enter A value: "
second_num=gets.to_f
# funny comparison
puts first_num.to_s + " <=>" + second_num.to_s + " = " + (first_num <=> second_num).to_s

=end


#--------------------------
=begin

# importing --->
load "module name"

=end

# endif = end
# break = exit

=begin

write_handler=File.new("main.out","w")
write_handler.puts("random text").to_s
write_handler.close

data_from_file=File.read("data.in")
puts data_from_file

=end

#-----------------------------

=begin

print "Enter Lang : "
lang=gets.chomp

case lang # switch
when "French"
	puts "bonjour"
	exit # break
when "Spanish"
	puts "hola"
	exit # break
else "english" # for readability , no meaning of eNglIsh
	puts "hello"
end

=end

#---------------------------

=begin
x=1
loop do
	x+=1
	next unless(x%2)==0 #continue
	puts x
	break if x>=10
end
=end

=begin
y=1
while y<=10
	y+=1
	next unless(y%2)==0 #continue
	puts y
end
=end

=begin
z=1
until z>=10
	z+=1
	next unless(z%2)==0 #continue
	puts z
end
=end

#-----------------------------------

=begin

numbers=[1,2,3,4,5] #generate as -->
#numbers = (0..5)

for number in numbers
# equivalent to numbers.each do |number|
	# bash style access
	print "what a number #{number}," #print doesnt add newline like puts
end

=end

#----------------------------

=begin

def add_nums(n1,n2)# passed by value
	return n1.to_i+n2.to_i
end
puts add_nums(3,4)

=end

#---------------------------------


print "Enter A value: "
first_num=gets.to_i
print "Enter A value: "
second_num=gets.to_i


# try catch:

begin
	answer=first_num/second_num
rescue
	puts "no zero div"
	exit
end

puts "ans is #{answer}"



















































#EOF

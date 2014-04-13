class Cuadricula
	@@line = 1
	attr_accessor :cuadricula1, :input1, :cuadricula2, :input2
	def initialize(options = {})
		@input1 = options[:input1]
		@input2 = options[:input2]
		@cuadricula1 = options[:cuadricula1]
		@cuadricula2 = options[:cuadricula2]
		@firstrow = @cuadricula1[input1]
		@secondrow = @cuadricula2[input2]
		writeresult
	end

	def writeresult
		output = ""
		count = 0
		if @firstrow === @secondrow
			output = "Bad magician!"
		else
			@firstrow.each do |x| 
				if @secondrow.include?(x)
					count = count + 1
					output = x
				end
			end
			output="Volunteer cheated!" if count==0
		end
		fw = File.open("output.in", "a+")
		fw.write("Case ##{@@line}: #{output}\n")
		@@line = @@line + 1
	end
end

f = File.open("input.in", "r")
firstline = f.first
posline = 2
count_i = 0
count_c = 0
posrow = 1
options = {:cuadricula1 => {"1"=>[],"2"=>[],"3"=>[],"4"=>[]}, :cuadricula2 => {"1"=>[],"2"=>[],"3"=>[],"4"=>[]} }

f.each_line do |line|
	line.strip!

	if line.length==1
		count_i == 0 ? options[:input1] = line : options[:input2] = line 
		count_i = count_i + 1
		count_c = count_c + 1
		posrow = 1
	end

	if line.length>=7
		count_c == 1 ? options[:cuadricula1][posrow.to_s] = line.split(" ") : options[:cuadricula2][posrow.to_s] = line.split(" ") 
		posrow = posrow + 1
	end

	if posrow == 5 && count_c==2 
		Cuadricula.new(options)
		count_i = 0
		count_c = 0
	end

	posline = posline +1
end

f.close
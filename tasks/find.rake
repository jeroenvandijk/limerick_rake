namespace :find do
	desc "Finds all occurrences similar to textmate but writes to standard output"
	task :all, [:query] do |t, args|
		Dir["{app,lib}/**/*"].each do |file|

			unless File.directory?(file)
				results = []
				File.open(file, 'r') do |f|
					f.each do |line|
						if line.match(args.query)
							results << [f.lineno, line]
						end
					end
				end
		
				if results.any?
					puts File.split(file).reverse.join(" -- ")
					results.each { |x| puts x[0].to_s.rjust(10) + ":#{x[1]}" }
				end
			end
		end
	end
end
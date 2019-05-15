require "yaml"
require "CSV"
require "pp"

projectsPage = "./projectspage.csv"

projectsPageYaml = "./projectspage.yaml"

data = CSV.read(projectsPage, :headers => true).map(&:to_hash)

File.open(projectsPageYaml, 'w') { |f| f.write(data.to_yaml) }

# script to turn the shared google spreadsheet-turned-csv into yaml for
# rendering in the jekyll front-end, in schedule.md (using liquid)

# class ClassList
#   attr_reader :header, :list
#   def initialize(csv)
#     csv_list = CSV.read csv # first row is header
#     @header = csv_list.shift.map {|h| h.gsub " ", "" }
#     @list = csv_list
#   end

#   def generate
#     @list
#       .map {|f| filterDate f  }
#       .reject {|f| f["Class"].nil? }
#       .map {|f| parseDate f }
#       .map {|f| parseRead f }
#       .map {|f| parseAssign f }
#       .map {|f| parseDue f }
#   end

#   private
#   def filterDate(fields)
#     Hash[fields
#       .each_with_index
#       .map { |c, i| c.nil?? nil : [@header[i], c.strip] }
#       .reject {|hc| hc.nil? || hc[1] =~ /^\s*$/ || hc[1] == " "}
#     ]
#   end

#   def parseDate(d)
#     d["Date"] = "2017 " + d["Date"].split("-").reverse.join(" ")
#     return d
#   end

#   def parseRead(d)
#     return d if d["Reading"].nil?
#     d["Reading"] = d["Reading"].split("\n").map { |r|
#       parseLink r
#     }.reject { |r| r.nil? || r.empty? }
#     return d
#   end

#   def parseAssign(d)
#     return d if d["Assign"].nil?
#     d["Assign"] = parseLink d["Assign"]
#     return d
#   end

#   def parseDue(d)
#     return d if d["Due"].nil?
#     d["Due"] = parseLink d["Due"]
#     return d
#   end

#   def parseLink(r)
#     s = r.strip.split(",")
#     if s.length == 1
#       r
#     else
#       {
#         "name" => s.first.strip,
#         "link" => s.last.strip,
#       }
#     end
#   end
# end

# # generate processed result
# cl = ClassList.new schedule
# full = cl.generate
# puts full.to_yaml

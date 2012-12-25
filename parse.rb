#!/usr/bin/ruby
require 'pp'

final = '/home/dave/Documents/vitalstring/mechturk/final/output/STANFORD/'
processed = '/home/dave/Documents/vitalstring/mechturk/processed/output/STANDFORD/'
args = []
debug = false
ARGV.each do |arg|
  if arg == "-d"
    debug = true
    next
  end
  args << "1C2-E-TEST-0" + "%03d" % arg + ".out"
end
Dir[processed + "*.out"].each do |full_path|
  ip = open(full_path, "r")
  file_name = full_path.split("/").last
  # uncomment below line for specific file debugging
  next if !args.empty? && !args.include?(file_name)
  puts "processing #{file_name}"
  op = open(final + file_name, "w")
  ip.readlines.each do |line|
    line = line.chomp
    puts line if debug
    str = ""
    parts=line.split("\t")
    if parts[0].include?("/")
      str=parts[0]
      if !parts[3].nil?
        str += "\t" + parts[3]
        if !parts[4].nil?
          str += "\t" + "DEP=" + parts[0].split("/").first + "%03d" % parts[4]
        end
      else
        # we don't have new vital string here so don't add anything
        str = ""
      end
    else
      str = line
    end
    if !str.empty?
      op.write(str+"\n")
    end
  end
  op.close
  ip.close
end


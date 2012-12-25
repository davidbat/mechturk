#!/usr/bin/ruby
require 'pp'

final = '/home/dave/Documents/vitalstring/mechturk/final/output/STANFORD/'
processed = '/home/dave/Documents/vitalstring/mechturk/processed/output/STANDFORD/'
Dir[processed + "*"].each do |full_path|
  puts "here"
  ip = open(full_path, "r")
  file_name = full_path.split("/").last
  op = open(final + file_name, "w")
  ip.readlines.each do |line|
    str = ""
    parts=line.chomp.split("\t")
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
  exit
end


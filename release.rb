#!/usr/bin/env ruby

require "pp"

STRINGS = {
  version: "3.1.0",
  homepage: "https://wargus.github.io",
  license: "GPL v2+",
  copyright: "(c) 1998-2021 by The Stratagus Project"
}

FILES = %w[wargus.rc wargus.nsi wartool.h mac/Info.plist scripts/stratagus.lua debian/copyright]
FILES << __FILE__

begin
  args = ARGV.map do |arg|
    if arg.start_with? "--"
      arg.sub("--", "").to_sym
    else
      arg
    end
  end
  input = Hash.[](*args)
rescue Exception
end

if input.nil? || input.empty? || (input.keys - STRINGS.keys).size > 0
  puts 'You can update the following STRINGS by passing --key "new-value"'
  pp STRINGS
  exit
end

if input[:version]
  STRINGS[:viversion] = STRINGS[:version].gsub(".", ",")
  input[:viversion] = input[:version].gsub(".", ",")
end

FILES.each do |name|
  File.open(name, 'a+') do |f|
    content = f.read
    f.truncate(0)
    input.each_pair do |k, v|
      content.gsub!(STRINGS[k], v)
    end
    f.write(content)
  end
end

if input[:version]
  system("dch -v#{input[:version]}-1")
  puts <<EOF

To release, run this:
# mark debian package as release
  dch -r

# review changes
  git add --patch

# commit and tag
  git commit -m "Release #{input[:version]}"
  git tag v#{input[:version]}
  git push --tags

EOF
end

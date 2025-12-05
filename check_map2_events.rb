#!/usr/bin/env ruby
# Check Map 2 events

File.open('Data/Map002.rxdata', 'rb') do |f|
  map = Marshal.load(f)
  puts "Map 2 Events:"
  map.events.each do |id, e|
    puts "  Event #{id}: #{e.name} at (#{e.x}, #{e.y})"
  end
end

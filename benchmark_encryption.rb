#!/usr/bin/env ruby
#===============================================================================
# Encryption Performance Benchmark
#===============================================================================

# Load the encryption module
load 'Plugins/[001] Advanced Asset Protection/[001] Config.rb'
load 'Plugins/[001] Advanced Asset Protection/[002] Encryption.rb'

puts "=" * 70
puts "Encryption Performance Benchmark"
puts "=" * 70

# Test data of various sizes
test_cases = [
  ["Small file (1 KB)", " " * 1024],
  ["Medium file (100 KB)", " " * (100 * 1024)],
  ["Large file (1 MB)", " " * (1024 * 1024)],
  ["Huge file (10 MB)", " " * (10 * 1024 * 1024)]
]

test_cases.each do |name, data|
  filepath = "Graphics/test.png"
  
  # Warm up
  AdvancedAssetProtection::Encryption.encrypt(data[0...1000], filepath)
  
  # Benchmark encryption
  start_time = Time.now
  10.times do
    AdvancedAssetProtection::Encryption.encrypt(data, filepath)
  end
  encrypt_time = (Time.now - start_time) / 10.0
  
  # Benchmark decryption
  encrypted = AdvancedAssetProtection::Encryption.encrypt(data, filepath)
  start_time = Time.now
  10.times do
    AdvancedAssetProtection::Encryption.decrypt(encrypted, filepath)
  end
  decrypt_time = (Time.now - start_time) / 10.0
  
  puts "\n#{name}:"
  puts "  Encryption: #{(encrypt_time * 1000).round(2)} ms"
  puts "  Decryption: #{(decrypt_time * 1000).round(2)} ms"
  puts "  Throughput: #{(data.size / (1024.0 * 1024.0) / encrypt_time).round(2)} MB/s"
end

puts "\n" + "=" * 70
puts "Benchmark complete!"
puts "=" * 70

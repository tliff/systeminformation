require 'lib/systeminformation/os.rb'
module SystemInformation
  def self.os
    OS::os
  end
  
  def self.cpu
    if OS::linux?
      @@cpu ||= Linux::CPU.new
      @@cpu.utilization
    end    
  end
  
  def self.load
    if OS::linux?
      Linux::Load.load
    end    
  end
  
  def self.net
    if OS::linux?
      @@net ||= Linux::Net.new
      @@net.throughput
    end    
  end
  
  def self.memory
    if OS::linux?
      Linux::Memory.usage
    end
  end
  
  def self.users
    if OS::unix?
      Unix::Users.loggedin
    end
  end
  
end

os = [:unix, :linux]
os.each do |o|
  if SystemInformation::OS::os == o
    puts (File.dirname(__FILE__) + "/systeminformation/#{o.to_s}/*.rb")
    Dir.glob(File.dirname(__FILE__) + "/systeminformation/#{o.to_s}/*.rb") do |i| 
      puts "loading #{i}"
      require i 
    end    
  end
end


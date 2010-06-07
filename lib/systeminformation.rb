os = [:unix, :linux]
os.each do |o|
  if SystemInformation::OS::os == o
    Dir.glob(File.dirname(__FILE__) + "/#{o.to_s}/*.rb") do |i| 
      require i 
    end    
  end
end

module SystemInformation
  def os
    OS::os
  end
  
  def cpu
    if OS::linux?
      @@cpu ||= Linux::CPU.new
      @@cpu.utilization
    end    
  end
  
  def load
    if OS::linux?
      Linux::Memory.usage
    end    
  end
  
  def net
    if OS::linux?
      Linux::Net.throughput
    end    
  end
  
  def memory
    if OS::linux?
      Linux::Memory.usage
    end
  end
  
  def users
    if OS::unix?
      Unix::Users.loggedin
    end
  end
  
end
require 'lib/systeminformation/os.rb'

module SystemInformation
  #Returns what operating system is running.
  #Valid return values are :linux, :solaris, :bsd, :darwin, :windows and :unknown
  def self.os
    OS::os
  end
  
  # Returns a hash of
  #  {
  #    "cpuid" => {
  #      :idle => 1.0, 
  #      :user => 0.0,
  #      ...
  #    },
  #    ...
  #  }
  #
  # The numerical values for each cpu sum up to 1.
  #
  # _Note:_ Since cpu utilisation is only defined for a time interval, the
  # first call to this methods does not return meaningful data. It should be
  # discarded and after a short time reexecuted. Subsequent calls will use
  # the previous call as reference.
  def self.cpu
    if OS::linux?
      @@cpu ||= Linux::CPU.new
      @@cpu.utilization
    end    
  end
  
  
  # Returns a hash of
  #  {
  #    :load_1 =>0.0,
  #    :load_5 =>0.0,
  #    :load_15 =>0.0,
  #    :procs_running =>0.0,
  #    :procs_total =>0.0
  #  }
  #
  def self.load
    if OS::linux?
      Linux::Load.load
    end    
  end
  
  # Returns a hash of
  #  {
  #    "eth0" => {
  #      :rbytes => 0.0,
  #      :rpackets=>0.0,
  #      :sbytes=>0.0,
  #      :spackets=>0.0
  #    },
  #   ...
  #  }
  #
  # values are bytes/second or packets/second respectively
  #
  # _Note:_ Since network throughput is only defined for a time interval, the
  # first call to this methods does not return meaningful data. It should be
  # discarded and after a short time reexecuted. Subsequent calls will use
  # the previous call as reference.
  def self.net
    if OS::linux?
      @@net ||= Linux::Net.new
      @@net.throughput
    end    
  end
  # Returns a hash of
  #  items = {
  #    :free=>23340,
  #    :cached=>106052,
  #    :buffers=>10864,
  #    :total=>505492,
  #    :swaptotal=>916472,
  #    :swapfree=>782652,
  #    :used=>365236,
  #    :swapused=>133820
  #  }
  #
  # The unit is kilobyte blocks.
  def self.memory
    if OS::linux?
      Linux::Memory.usage
    end
  end
  
  # Returns the number of currently logged in users as an integer
  def self.users
    if OS::unix?
      Unix::Users.loggedin
    end
  end
  
end

os = [:unix, :linux]
os.each do |o|
  if SystemInformation::OS::os == o
    Dir.glob(File.dirname(__FILE__) + "/systeminformation/#{o.to_s}/*.rb") do |i| 
      require i 
    end    
  end
end


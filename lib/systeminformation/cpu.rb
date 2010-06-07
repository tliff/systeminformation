module SystemInformation
  class CPU
    case SystemInformation::OS.os
    when :linux
      require 'lib/systeminformation/linux/cpu.rb'
      include SystemInformation::Linux::CPU
    end
  end
end
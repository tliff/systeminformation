module SystemInformation
  class Load
    case SystemInformation::OS.os
    when :linux
      require 'lib/systeminformation/linux/load.rb'
      include SystemInformation::Linux::Load
    end
  end
end
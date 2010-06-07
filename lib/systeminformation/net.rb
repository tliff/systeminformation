module SystemInformation
  class Net
    case SystemInformation::OS.os
    when :linux
      require 'lib/systeminformation/linux/net.rb'
      include SystemInformation::Net::Load
    end
  end
end
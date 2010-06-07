if /java/.match(RUBY_PLATFORM)
  require 'java'
  import 'java.lang.System'
end


module SystemInformation
  module OS
    def self.os
      return @os if @os
      name = RUBY_PLATFORM
      @os = case name
      when /linux/
        :linux
      when /solaris/
        :solaris
      when /bsd/
        :bsd
      when /darwin/ 
        :darwin
      when /win/
        :windows
      else
        :unknown
      end
    end

    def self.unix?
      [:linux, :bsd, :darwin, :solaris].member?(os)
    end
    
    def self.linux?
      os == :linux
    end
    
  end
end
if /java/.match(RUBY_PLATFORM)
  require 'java'
  import 'java.lang.System'
end


module SystemInformation
  module OS
    def self.os
      return @os if @os
      os_name = RUBY_PLATFORM
      os_name = System.getProperty('os.name').downcase if jruby?
      puts @os_name
      @os = case os_name
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

    def self.java?
      !(/java/.match(RUBY_PLATFORM).nil?)
    end

    def self.jruby?
      java? && /jruby/.match(RUBY_ENGINE)
    end  
  end
end
module SystemInformation
  module Linux
    module Users
      def self.loggedin
        count = 0
        IO.popen('who') do |p|
          count = p.readlines.size
        end
        return count
      end
    end
  end
end
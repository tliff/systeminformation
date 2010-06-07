module SystemInformation
  module Linux
    module Load
      def self.load
        data = {}
        File.open('/proc/loadavg','r') do |f|
          line = f.readline
          data[:load_1], data[:load_5], data[:load_15], processes = line.split
          data[:procs_runnning], data[:procs_total] = processes.split('/')
        end
        return data
      end
    end
  end
end
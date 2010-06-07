module SystemInformation
  module Linux
    class Net
      def initialize
        @prev_data = get_data
	@prev_time = Time.now
      end
      
      def throughput
        new_data = get_data
        difference ={}
	delta = Time.now - @prev_time
        @prev_data.keys.each{|k|
          difference[k] = @prev_data[k].zip(new_data[k]).map{|i| (i[1].to_f - i[0].to_f)/delta}
        }
        @prev_data = new_data
	@prev_time = Time.now
        result={}
        difference.each{|k,body|
          result[k] = {:rbytes => body[0], :rpackets => body[1], :sbytes => body[2], :spackets => body[3]}
        }
        result
      end
      
      private
      def get_data
        delta = nil
        data = {}
        File.open('/proc/net/dev','r') do |f|
          f.readlines.select{|l| l =~ /:/}.each do |l|
            l.gsub!(/ +/,' ').strip!
            id, body = l.split(':')
            body = body.strip.split
            data[id] = [body[0],body[1],body[8],body[9]]
          end
        end
        data
      end
    end
  end
end

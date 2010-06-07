require 'pp'
module SystemInformation
  module Linux
    module CPU
      def initialize
        @prev_data = read_data
      end
      
      def get_data
        new_data = read_data
        returnhash = {}
        new_data.keys.each do |key|
          difference = @prev_data[key].zip(new_data[key]).map{|i| i[1].to_f - i[0].to_f}
          difference
          sum = difference.inject{|a,b| a+b}

          difference.map!{|i| i/sum}.map!{|i| i.nan? ? 0 : i}
          returnhash[key] = {
            :user => difference[0],
            :nice => difference[1],
            :system => difference[2],
            :idle => difference[3],
            :running => difference[4],
            :iowait => difference[5],
            :irq => difference[6],
            :softirq => difference[7]
          }
        end
        @prev_data = new_data
        return returnhash
      end
      
      private
      def read_data
        data = {}
        File.open('/proc/stat','r') do |f|
          f.readlines.select{|l| l =~ /^(cpu\d*) /}.each do |l|
            cpu, *rest = l.split
            data[cpu] = rest
          end
        end
        data
      end
      
      
    end
  end
end

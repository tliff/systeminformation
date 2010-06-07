module SystemInformation
  module Linux
    module Memory
      def self.usage
        items = {
          :free => 'MemFree',
          :cached => 'Cached',
          :buffers => 'Buffers',
          :total => 'MemTotal',
          :swaptotal => 'SwapTotal',
          :swapfree => 'SwapFree'
        }

        File.open('/proc/meminfo','r') do |f|
          f.readlines.each do |l|
            items.each_pair do |i, k|
              if matches = Regexp.new("#{k}: +([0-9]+)").match(l)
                items[i] = matches[1].to_i
              end
            end
          end
          items[:used] = items[:total] - items[:free] - items[:cached] - items[:buffers]
          items[:swapused] = items[:swaptotal] - items[:swapfree]
        end
        return items
      end
    end
  end
end
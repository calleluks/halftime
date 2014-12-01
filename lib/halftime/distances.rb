module Halftime
  module Distances
    class Distance
      def initialize(duration)
        @duration = duration
      end

      private

      attr_reader :duration
    end

    class Seconds < Distance
      def from(time)
        time.advance(seconds: duration)
      end
    end

    class Minutes < Distance
      def from(time)
        time.advance(minutes: duration)
      end
    end

    class Hours < Distance
      def from(time)
        time.advance(hours: duration)
      end
    end

    class Days < Distance
      def from(time)
        time.advance(days: duration)
      end
    end

    class Weeks < Distance
      def from(time)
        time.advance(weeks: duration)
      end
    end

    class Months < Distance
      def from(time)
        time.advance(months: duration)
      end
    end

    class Years < Distance
      def from(time)
        time.advance(years: duration)
      end
    end
  end
end

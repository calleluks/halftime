module Halftime
  module DateFactories
    class Unambiguous
      def initialize(year, month, day)
        @year = year
        @month = month
        @day = day
      end

      def new(_)
        Date.new(year, month, day)
      end

      def ambiguous?
        false
      end

      private

      attr_reader :year, :month, :day
    end

    class Ambiguous
      def new
        raise NotImplementedError
      end

      def ambiguous?
        true
      end
    end

    class Today < Ambiguous
      def new(current)
        current
      end
    end

    class Tomorrow < Ambiguous
      def new(current)
        current.tomorrow
      end
    end

    class Weekday < Ambiguous
      def self.monday
        new(1)
      end

      def self.tuesday
        new(2)
      end

      def self.wednesday
        new(3)
      end

      def self.thursday
        new(4)
      end

      def self.friday
        new(5)
      end

      def self.saturday
        new(6)
      end

      def self.sunday
        new(7)
      end

      def new(current)
        if current.wday < weekday_number
          current + (weekday_number - current.wday)
        else
          current + (7 - current.wday + weekday_number)
        end
      end

      private

      def initialize(weekday_number)
        @weekday_number = weekday_number
      end

      attr_reader :weekday_number
    end

    class MonthDay < Ambiguous
      def initialize(month, day)
        @month = month
        @day = day
      end

      def new(current)
        advance(Date.new(current.year, month, day), current)
      end

      private

      attr_reader :month, :day

      def advance(date, current)
        if date <= current
          date.advance(years: 1)
        else
          date
        end
      end
    end
  end
end

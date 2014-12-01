require "active_support"
require "active_support/core_ext"
require "halftime/date_factories"
require "halftime/distances"
require "halftime/meridies"
require "halftime/time_factories"
require "halftime/time_of_day"
require "halftime/time_zones"
require "parslet"

module Halftime
  class Transform < Parslet::Transform
    rule integer: simple(:string) do
      string.to_i
    end

    rule january: simple(:january) do
      1
    end

    rule february: simple(:january) do
      2
    end

    rule march: simple(:march) do
      3
    end

    rule april: simple(:april) do
      4
    end

    rule may: simple(:may) do
      5
    end

    rule june: simple(:june) do
      6
    end

    rule july: simple(:july) do
      7
    end

    rule august: simple(:august) do
      8
    end

    rule september: simple(:september) do
      9
    end

    rule october: simple(:october) do
      10
    end

    rule november: simple(:november) do
      11
    end

    rule december: simple(:december) do
      12
    end

    rule tomorrow: simple(:tomorrow) do
      DateFactories::Tomorrow.new
    end

    rule monday: simple(:monday) do
      DateFactories::Weekday.monday
    end

    rule tuesday: simple(:tuesday) do
      DateFactories::Weekday.tuesday
    end

    rule wednesday: simple(:wednesday) do
      DateFactories::Weekday.wednesday
    end

    rule thursday: simple(:thursday) do
      DateFactories::Weekday.thursday
    end

    rule friday: simple(:friday) do
      DateFactories::Weekday.friday
    end

    rule saturday: simple(:saturday) do
      DateFactories::Weekday.saturday
    end

    rule sunday: simple(:sunday) do
      DateFactories::Weekday.sunday
    end

    rule month: simple(:month), day: simple(:day) do
      DateFactories::MonthDay.new(month, day)
    end

    rule month: simple(:month), day: simple(:day), year: simple(:year) do
      DateFactories::Unambiguous.new(year, month, day)
    end

    rule am: simple(:am) do
      Meridies::Am
    end

    rule pm: simple(:am) do
      Meridies::Pm
    end

    rule time_of_day_components: subtree(:time_of_day_components) do
      TimeOfDay.new(time_of_day_components)
    end

    rule utc: simple(:utc) do
      TimeZones::UTC
    end

    rule absolute: subtree(:absolute) do
      TimeFactories::Absolute.new(absolute)
    end

    rule years: simple(:years) do
      Distances::Years
    end

    rule months: simple(:months) do
      Distances::Months
    end

    rule weeks: simple(:weeks) do
      Distances::Weeks
    end

    rule days: simple(:days) do
      Distances::Days
    end

    rule hours: simple(:hours) do
      Distances::Hours
    end

    rule minutes: simple(:minutes) do
      Distances::Minutes
    end

    rule seconds: simple(:seconds) do
      Distances::Seconds
    end

    rule duration: simple(:duration), unit: simple(:unit) do
      unit.new(duration)
    end

    rule relative: subtree(:relative) do
      TimeFactories::Relative.new(relative)
    end
  end
end

require "parslet"

module Halftime
  class InternalParser < Parslet::Parser
    root :time_factory

    rule :time_factory do
      relative | absolute
    end

    rule :relative do
      in? >> distance.as(:relative) >> from_now?
    end

    rule :in? do
      str("in").maybe >> spaces?
    end

    rule :from_now? do
      spaces? >> (str("from") >> spaces? >> str("now")).maybe >> spaces?
    end

    rule :distance do
      (duration >> spaces? >> unit).as(:distance)
    end

    rule :duration do
      digit.repeat(1).as(:integer).as(:duration)
    end

    rule :unit do
      (years | months | weeks | days | hours | minutes | seconds).as(:unit)
    end

    rule :years do
      plural_stri("year").as(:years)
    end

    rule :months do
      plural_stri("month").as(:months)
    end

    rule :weeks do
      plural_stri("week").as(:weeks)
    end

    rule :days do
      plural_stri("day").as(:days)
    end

    rule :hours do
      plural_stri("hour").as(:hours)
    end

    rule :minutes do
      plural_stri("minute").as(:minutes)
    end

    rule :seconds do
      plural_stri("second").as(:seconds)
    end

    rule :absolute do
      (date_and_or_time_of_day >> time_zone?).as(:absolute)
    end

    rule :date_and_or_time_of_day do
      on? >> date >> at? >> time_of_day.maybe |
        at? >> time_of_day >> on? >> date.maybe
    end

    rule :date do
      (tomorrow | weekday | numerical_date | date_with_month_name).
        as(:date_factory)
    end

    rule :on? do
      spaces? >> str("on").maybe >> spaces?
    end

    rule :tomorrow do
      stri("tomorrow").as(:tomorrow)
    end

    rule :weekday do
      next? >>
        (monday | tuesday | wednesday | thursday | friday | saturday | sunday)
    end

    rule :next? do
      stri("next").maybe >> spaces?
    end

    rule :monday do
      (stri("monday") | stri("mon")).as(:monday)
    end

    rule :tuesday do
      (stri("tuesday") | stri("tue")).as(:tuesday)
    end

    rule :wednesday do
      (stri("wednesday") | stri("wed")).as(:wednesday)
    end

    rule :thursday do
      (stri("thursday") | stri("thu")).as(:thursday)
    end

    rule :friday do
      (stri("friday") | stri("fri")).as(:friday)
    end

    rule :saturday do
      (stri("saturday") | stri("sat")).as(:saturday)
    end

    rule :sunday do
      (stri("sunday") | stri("sun")).as(:sunday)
    end

    rule :numerical_date do
      numerical_month_day >> (date_separator >> year).maybe |
        (year >> date_separator).maybe >> numerical_month_day
    end

    rule :numerical_month_day do
      month_number >> date_separator >> day |
        day >> date_separator >> month_number
    end

    rule :date_with_month_name do
      named_month_day >> (spaces >> year).maybe |
        (year >> spaces).maybe >> named_month_day
    end

    rule :named_month_day do
      month_name >> spaces? >> day | day >> spaces? >> month_name
    end

    rule :month_name do
      (january | february | march | april | may | june | july | august |
       september | october | november | december).as(:month)
    end

    rule :january do
      (stri("January") | stri("Jan")).as(:january)
    end

    rule :february do
      (stri("February") | stri("Feb")).as(:february)
    end

    rule :march do
      (stri("March") | stri("Mar")).as(:march)
    end

    rule :april do
      (stri("April") | stri("Apr")).as(:april)
    end

    rule :may do
      stri("May").as(:may)
    end

    rule :june do
      (stri("June") | stri("Jun")).as(:june)
    end

    rule :july do
      (stri("July") | stri("Jul")).as(:july)
    end

    rule :august do
      (stri("August") | stri("Aug")).as(:august)
    end

    rule :september do
      (stri("September") | stri("Sep")).as(:september)
    end

    rule :october do
      (stri("October") | stri("Oct")).as(:october)
    end

    rule :november do
      (stri("November") | stri("Nov")).as(:november)
    end

    rule :december do
      (stri("December") | stri("Dec")).as(:december)
    end

    rule :month_number do
      one_to_twelve.as(:month)
    end

    rule :one_to_twelve do
      (str("1") >> match("[0-2]") |
       str("0").maybe >> match("[1-9]")).as(:integer)
    end

    rule :date_separator do
      match("[/\-]")
    end

    rule :day do
      one_to_thirty.as(:day)
    end

    rule :one_to_thirty do
      (str("3") >> match("[0-1]") |
       match("[1-2]") >> digit |
       str("0").maybe >> match("[1-9]")).as(:integer)
    end

    rule :year do
      digit.repeat(4).as(:integer).as(:year)
    end

    rule :digit do
      match("[0-9]")
    end

    rule :time_of_day do
      time_of_day_components.as(:time_of_day)
    end

    rule :time_of_day_components do
      (hour >>
       time_separator? >> minute? >>
       time_separator? >> second? >>
       spaces? >> meridiem?).as(:time_of_day_components)
    end

    rule :at? do
      str("T") | spaces? >> (str("at") | str("@")).maybe >> spaces?
    end

    rule :hour do
      zero_to_twentyfour.as(:hour)
    end

    rule :zero_to_twentyfour do
      (str("2") >> match("[0-4]") |
       match("[0-1]").maybe >> digit |
       digit).as(:integer)
    end

    rule :time_separator? do
      match("[:.]").maybe
    end

    rule :minute? do
      zero_to_fiftynine.as(:minute).maybe
    end

    rule :second? do
      zero_to_fiftynine.as(:second).maybe
    end

    rule :zero_to_fiftynine do
      (match("[0-5]").maybe >> digit | digit).as(:integer)
    end

    rule :meridiem? do
      (am | pm).as(:meridiem_factory).maybe
    end

    rule :am do
      str("am").as(:am)
    end

    rule :pm do
      str("pm").as(:pm)
    end

    rule :spaces? do
      spaces.maybe
    end

    rule :spaces do
      str(" ").repeat(1)
    end

    rule :time_zone? do
      (utc).as(:time_zone).maybe
    end

    rule :utc do
      str("Z").as(:utc)
    end

    def plural_stri(string)
      stri(string) >> stri("s").maybe
    end

    def stri(string)
      string.
        split(//).
        map! { |char| match("[#{char.upcase}#{char.downcase}]") }.
        reduce(:>>)
    end
  end
end

Halftime
========

[![Build Status](https://travis-ci.org/calleerlandsson/halftime.svg)](https://travis-ci.org/calleerlandsson/halftime)

A natural language time parser.

Installation
------------

Add this line to your application's Gemfile:

    gem "halftime"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install halftime

Usage
-----

    require "halftime"

    Halftime::Parser.new("tomorrow at 12", now: Time.now).time

If a time can not be parsed from the passed string, `Halftime::Parser#time` will
return `nil`.

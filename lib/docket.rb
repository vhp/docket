#!/usr/bin/env ruby
require 'task'


# Docket is the structure that holds all of our tasks
class Docket

  def initialize(opts)
    @opts = opts
    @tasks = []
  end

  # Intake previous tasks
  def intake()
    puts @opts
  end
end

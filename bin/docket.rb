#!/usr/bin/env ruby
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'docopt'
require 'config'
require 'docket'

doc = <<DOCOPT
Docket - Simple todo list manager.

Usage:
  #{__FILE__}
  #{__FILE__} add <text>...
  #{__FILE__} (<filter>) <note>...
  #{__FILE__} (<filter>) done
  #{__FILE__} -c <config_path>
  #{__FILE__} -l <library>
  #{__FILE__} -h | --help
  #{__FILE__} --version

Options:
  -h --help     Show this screen.
  --version     Show version.

DOCOPT

begin
  config = Config.new(Docopt::docopt(doc, version: '0.1'))
  opts = config.get_opts()
  Docket.new(opts)
rescue Docopt::Exit => e
  puts e.message
end

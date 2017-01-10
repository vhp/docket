#!/usr/bin/env ruby
require 'json'

# Application configuration.
# * Creates needed files and directories
# * Merge default settings into config settings
#    and then those into command line arguments
class Config

  def initialize(cmd_opts)
    @defaults = {"<config_path>"=>'~/.docket.rc',
                 "<library>"=>'~/.docket.tasks'
                }
    write_default(cmd_opts["<config_path>"])
    create_library(cmd_opts["<library>"])
    @loaded = load_config(cmd_opts["<config_path>"])
    @opts = cmd_opts.merge(@loaded.merge(@defaults))
  end

  # Return final options after read from config and double merge
  def get_opts()
    return @opts
  end

  # Create library directory
  def create_library(library_path)
    library_path ||= @defaults["<library>"]
    library_path = File.expand_path(library_path)
    Dir.mkdir library_path unless File.exists? library_path
  end

  # Write out config
  def write_default(config_file_path)
    config_file_path ||= @defaults["<config_path>"]
    config_file_path = File.expand_path(config_file_path)
    unless File.file?(config_file_path)
     File.open(config_file_path, 'w') do |f|
       f.write(JSON.pretty_generate(@defaults))
     end
    end
  end

  # Merge settings from config with settings passed in from command line.
  # Return merged settings in hash.
  def merge_settings(cmd_line_args, config_args)
    merged_args = cmd_line_args.merge(config_args)
    return merged_args
  end

  # Load config and parse it. Return the parsed
  # json encoding of the file.
  def load_config(config_path)
    config_path ||= @defaults["<config_path>"]
    config_path = File.expand_path(config_path)
    if File.file?(config_path)
      begin
        config_json = JSON.parse(File.read(config_path))
        return config_json
      rescue
        abort "Could not read #{config_path} file"
      end
    else
      abort "Config file didn't exist."
    end
  end
end

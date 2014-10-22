begin
  require 'puppet/util/log'

  # restart the puppetmaster when changed
  module Puppet::Parser::Functions
    newfunction(:oracle_webgate_exists, :type => :rvalue) do |args|
      webgate = lookup_db_var('oracle_webgate_ver')
      if webgate == 'empty' or webgate == 'NotFound'
        log 'oracle_webgate_exists return empty -> false'
        return false
      else
        log 'oracle_webgate_exists version #{webgate} -> true'
        return true
      end
    end
  end

  # Copied from
  # https://github.com/biemond/biemond-oradb/blob/master/lib/puppet/parser/functions/oracle_exists.rb
  def lookup_db_var(name)
    # puts "lookup fact "+name
    if db_var_exists(name)
      return lookupvar(name).to_s
    end
    'empty'
  end

  def db_var_exists(name)
    # puts "lookup fact "+name
    if lookupvar(name) != :undefined
      if lookupvar(name).nil?
        # puts "return false"
        return false
      end
      return true
    end
    # puts "not found"
    false
  end

  def log(msg)
    Puppet::Util::Log.create(
      :level   => :info,
      :message => msg,
      :source  => 'oracle_webgate_exists'
    )
  end

end

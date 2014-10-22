require"puppet"

module Puppet::Parser::Functions
  newfunction(:oracle_webgate_exists, :type => :rvalue) do |args|
    if File.exists?(args[0])
      return true
    else
      return false
    end
  end
end

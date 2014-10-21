begin
  require 'puppet/util/log'
  require 'rexml/document'
  require 'facter'

  # restart the puppetmaster when changed
  module Puppet::Parser::Functions
    newfunction(:oracle_webgate_exists, :type => :rvalue) do |args|
      log "oracle_webgate_exists #{path}, #{version}"

      if is_webgate_installed?(path, version)
        log 'oracle_webgate_exists ${version} return true'
        return true
      end

      log 'oracle_webgate_exists ${version} return false'
      return false
    end
  end

  def is_webgate_installed?(path, version)
    unless path.nil?
      if FileTest.exists?(path + '/ContentsXML/comps.xml')
        file = File.read(path + '/ContentsXML/comps.xml')
        doc = REXML::Document.new file
        doc.elements.each('/PRD_LIST/TL_LIST/COMP') do |element|
          ver = element.attributes['VER']
          return (version == ver)
        end
      end
    end

    return false
  end

  def log(msg)
    Puppet::Util::Log.create(
      :level   => :info,
      :message => msg,
      :source  => 'oracle_webgate_exists'
    )
  end

end

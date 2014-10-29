Facter.add("oracle_webgate_exists") do
  setcode do
    if File.exists? '/opt/netpoint/webgate/access/.puppet-oracle_webgate-configured'
      true
    else
      false
    end
  end
end

Facter.add("oracle_webgate_patch") do
  setcode do
    if !Dir.glob('/opt/netpoint/webgate/access/oblix/config/np*.txt').empty?
      np = Dir['/opt/netpoint/webgate/access/oblix/config/np*.txt'][0]
      str = IO.read(np)
      match = str.match(/^Release: .* BP(\d+)$/)
      match[1].to_i
    else
      '0'.to_i
    end
  end
end


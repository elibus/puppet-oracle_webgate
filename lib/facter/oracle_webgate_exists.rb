Facter.add("oracle_webgate_exists") do
  setcode do
    if File.exists? '/opt/netpoint/webgate/access/.puppet-oracle_webgate-configured'
      true
    else
      false
    end
  end
end

Facter.add("oracle_webgate_exists") do
  setcode do
    if File.exists? '/opt/netpoint/webgate/access/oblix/config/random-seed'
      true
    else
      false
    end
  end
end

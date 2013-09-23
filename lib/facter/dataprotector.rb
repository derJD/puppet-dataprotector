Facter.add(:dataprotector) do
  setcode do
    if File.exist? '/etc/opt/omni/client/omni_info'
      true
    else
      false
    end
  end
end

if Facter.value('dataprotector') == true
  File.readlines('/etc/opt/omni/client/omni_info').each do |line|
    core_line = /^\-key\ core\ (.*)\-version\ /.match(line)
    if core_line
      Facter.add(:dataprotector_version) do
        setcode do
          core_line.post_match.chomp
        end
      end
    end
  end
end 

Facter.add(:dataprotector_patch) do
  confine :dataprotector => true
  setcode do
    patchlevel = File.read('/opt/omni/.patch_core')
    patchlevel.chomp
  end
end

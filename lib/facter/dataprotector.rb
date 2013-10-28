Facter.add(:dataprotector) do
  setcode { File.exist?('/etc/opt/omni/client/omni_info') ? true : false }
end

if Facter.value('dataprotector')
  File.readlines('/etc/opt/omni/client/omni_info').each do |line|
    Facter.add(:dataprotector_version) do
      version = (/^\-key\ core\ (.*)\-version\ /.match(line)).post_match.chomp
      setcode {  version } unless version.empty?
    end
  end

  Facter.add(:dataprotector_patch) do
    setcode { (File.read('/opt/omni/.patch_core')).chomp }
  end
end 


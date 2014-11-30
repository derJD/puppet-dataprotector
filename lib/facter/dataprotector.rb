Facter.add(:dataprotector) do
  setcode do
    dataprotector = { }
    dataprotector['installed'] = File.exist?('/etc/opt/omni/client/omni_info') ? true : false

    if dataprotector['installed'] == true
      dataprotector['component'] = {  }
      File.readlines('/etc/opt/omni/client/omni_info').each do |line| 
        component = /\-key\ (.*)\ -desc.*\-version\ (.*)($|\n)/.match(line)
        patch = File.exist?("/opt/omni/.patch_#{ component[1] }") ? File.read("/opt/omni/.patch_#{ component[1] }").chomp : "none"
        dataprotector['component']["#{ component[1] }"] = {
          'version' => "#{ component[2] }",
          'patch'   => "#{ patch }"
        }
      end
    end
    dataprotector
  end
end

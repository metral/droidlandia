class AdbWorker
  @queue = :adb_queue 

  def self.perform(apk_bin_id)
    apk_bin = ApkBin.find(apk_bin_id)
    puts "Launcing apk File: #{apk_bin.apk.path}  Intent: #{apk_bin.intent}"
    %x(touch /tmp/bob_sucks)
    %x(dscp kn[1-520] #{apk_bin.apk.path})
  end
end

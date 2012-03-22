class AdbWorker
  @queue = :adb_queue 

  def self.perform(apk_bin_id)
    apk_bin = ApkBin.find(apk_bin_id)
    puts "--------------------------------------------------"
    puts "Launching apk File: #{apk_bin.apk.path}  Intent: #{apk_bin.intent}"

    adb_connect_cmd = "adb connect " + "10.2.2.12:5555"
    result = %x(#{adb_connect_cmd})
    puts "Connect Results: " + result

    adb_install_cmd = "adb install " + apk_bin.apk.path
    result = %x(#{adb_install_cmd})
    puts "Install Results: " + result

    adb_disconnect_cmd = "adb disconnect " + "10.2.2.12:5555"
    result = %x(#{adb_disconnect_cmd})
    puts "Disconnect Results: " + result
  end
end

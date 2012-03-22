class AdbWorker
  @queue = :adb_queue 
  
  # Temp port used for testing
  @ip_port = "10.2.2.12:5555"

  def self.perform(apk_bin_id)
    
    # Find the apk in the db
    apk_bin = ApkBin.find(apk_bin_id)

    puts "--------------------------------------------------"
    puts "Launching apk File: #{apk_bin.apk.path}  Intent: [#{apk_bin.intent}]"

    r = %x(adb connect #{@ip_port})
    puts "Connect Results: #{r}"

    r = %x(adb install #{apk_bin.apk.path})
    puts "Install Results: #{r}"
    
    r = %x(adb shell am start -a android.intent.action.MAIN -n #{apk_bin.intent})
    puts "Start result: #{r}"

    r = %x(adb disconnect #{@ip_port})
    puts "Disconnect Results: #{r}"

    puts "Done..."
  end
end

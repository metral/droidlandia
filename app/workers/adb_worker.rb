class AdbWorker
  @queue = :adb_queue 
  
  # Temp port used for testing
  @ip_port = "10.2.2.12:5555"

  def self.perform(apk_bin_id)
    
    # Find the apk in the db
    apk_bin = ApkBin.find(apk_bin_id)

    puts "--------------------------------------------------"
    puts "Launching apk File: #{apk_bin.apk.path}  Intent: [#{apk_bin.intent}]"

    puts "Extracting starting intent: "
    r = %x(aapt dump badging #{apk_bin.apk.path})
    adb_re=/launchable-activity: name='([a-zA-Z\.]*)'/
    
    m = adb_re.match(r)
    unless m
        puts "There was no match..."
        exit
    end
    
    puts "Found matching result: #{m[0]}"
    puts "Found Starting Intent: #{m[1]}"

    start_intent = m[1]
    package = start_intent.split('.')[0 .. -2].join('.')
    launch_string = "#{package}/#{start_intent}"

    r = %x(adb connect #{@ip_port})
    puts "Connect Results: #{r}"

    r = %x(adb install #{apk_bin.apk.path})
    puts "Install Results: #{r}"
    
    #r = %x(adb shell am start -a android.intent.action.MAIN -n #{apk_bin.intent})
    r = %x(adb shell am start -n #{launch_string})
    puts "Start result: #{r}"

    r = %x(adb disconnect #{@ip_port})
    puts "Disconnect Results: #{r}"

    puts "Done..."
  end
end

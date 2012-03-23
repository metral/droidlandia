class AdbWorker
  @queue = :adb_queue 
  
  # Temp port used for testing
  @ip_port = "10.2.2.12:5555"

  @ip_port_list = ["10.2.2.12:5555", 
                   "10.2.2.13:5555",
                   "10.2.2.14:5555",
                   "10.2.2.15:5555"]

  def self.adb_launch(apk_path, intent, ip_port)
    
    puts "#{ip_port}: Connecting..."
    r = %x(adb connect #{ip_port})
    puts "#{ip_port}: Connect Results: #{r}"

    puts "#{ip_port}: Installing..."
     r = %x(adb -s #{ip_port} install #{apk_path})
    puts "#{ip_port}: Install Results: #{r}"
    
    puts "#{ip_port}: Starting..."
    r = %x(adb -s #{ip_port} shell am start -n #{intent})
    puts "#{ip_port}: Start result: #{r}"

    puts "#{ip_port}: Disconnecting..."
    r = %x(adb disconnect #{ip_port})
    puts "#{ip_port}: Disconnect Results: #{r}"

  end

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
   
    puts "Starting threads"
    thd_list = []
    @ip_port_list.each do |ip_port|
        puts "Starting thread #{ip_port}"
        t = Thread.new{ self.adb_launch(apk_bin.apk.path, launch_string, ip_port) }
        thd_list.push(t)
    end

    thd_list.each do |t|
        t.join
    end
    
    puts "DONE!!!"

    #r = %x(adb connect #{@ip_port})
    #puts "Connect Results: #{r}"

    #r = %x(adb install #{apk_bin.apk.path})
    #puts "Install Results: #{r}"
    #
    ##r = %x(adb shell am start -a android.intent.action.MAIN -n #{apk_bin.intent})
    #r = %x(adb shell am start -n #{launch_string})
    #puts "Start result: #{r}"

    #r = %x(adb disconnect #{@ip_port})
    #puts "Disconnect Results: #{r}"

    #puts "Done..."
  end
end

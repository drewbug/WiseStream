class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    UI7Kit.patchIfNeeded
    initialize_storage
    initialize_sensors
    open HomeScreen.new(nav_bar: true)
    alert = UIAlertView.new.tap { |a| a.title = 'Loading...'; a.message = 'Please wait...' }.show
    initialize_audio do
      alert.dismissWithClickedButtonIndex 0, animated: true
    end
  end

  def initialize_storage
    {compass_enabled: false, compass_volume: 0.75,
     clock_enabled: false, clock_volume: 0.75,
     magnetometer_enabled: false, magnetometer_volume: 0.75,
     accelerometer_enabled: false, accelerometer_volume: 0.75}.each do |key, value|
      App::Persistence[key] = value if App::Persistence[key].nil?
    end
  end

  def initialize_sensors
    App.states[:motion_manager] = CMMotionManager.new
  end

  def initialize_audio(&block)
    App.states[:audio_context] = Pachelbel::AudioContext.new
    App.states[:compass_streamer] = CompassStreamer.new App.states[:audio_context]
    App.states[:clock_streamer] = ClockStreamer.new App.states[:audio_context]
    App.states[:magnetometer_streamer] = MagnetometerStreamer.new App.states[:audio_context]
    App.states[:accelerometer_streamer] = AccelerometerStreamer.new App.states[:audio_context]
    App.states[:audio_context].on_ready(&block)
  end
end

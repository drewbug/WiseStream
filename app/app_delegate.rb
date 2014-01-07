class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    initialize_storage
    initialize_audio
    open HomeScreen.new(nav_bar: true)
  end

  def initialize_storage
    {compass_enabled: false, compass_volume: 0.75,
     clock_enabled: false, clock_volume: 0.75}.each do |key, value|
      App::Persistence[key] = value if App::Persistence[key].nil?
    end
  end

  def initialize_audio
    App.states[:audio_context] = Pachelbel::AudioContext.new
    App.states[:compass_streamer] = CompassStreamer.new App.states[:audio_context]
    App.states[:clock_streamer] = ClockStreamer.new App.states[:audio_context]
  end
end

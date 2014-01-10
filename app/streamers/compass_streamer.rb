class CompassStreamer < BaseStreamer
  def __key__
    :compass
  end

  def on_init
    App.states[:location_manager].delegate = self
    @on_update = nil
  end

  def on_ready
    @oscillator = @audio_context.createOscillator
    @oscillator.connect @gain_node
    @oscillator.start(0)
    if App.states[:location_manager].headingAvailable
      App.states[:location_manager].startUpdatingHeading
    end
  end

  def locationManager(_, didUpdateHeading: heading)
    @oscillator.frequency = calculate_frequency(heading.magneticHeading)
    @on_update.call heading.magneticHeading unless @on_update.nil?
  end

  def calculate_frequency(heading)
   ((heading - 180).abs * (( App::Persistence[:"#{__key__}_freq0360"] - App::Persistence[:"#{__key__}_freq180"] ) / 180 )) + App::Persistence[:"#{__key__}_freq180"]
  end

  def on_update(&block)
    @on_update = block
  end

  def stop_updates
    @on_update = nil
  end

  def freq180
    App::Persistence[:"#{__key__}_freq180"]
  end

  def freq180=(value)
    App::Persistence[:"#{__key__}_freq180"] = value
  end

  def freq0360
    App::Persistence[:"#{__key__}_freq0360"]
  end

  def freq0360=(value)
    App::Persistence[:"#{__key__}_freq0360"] = value
  end
end

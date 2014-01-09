class MagnetometerStreamer < BaseStreamer
  def __key__
    :magnetometer
  end

  def on_init
    @on_update = nil
  end

  def on_ready
    @oscillator = @audio_context.createOscillator
    @oscillator.connect @gain_node
    @oscillator.start(0)
    if App.states[:motion_manager].isMagnetometerAvailable
       handler = lambda { |data, error| field_update(data.magneticField) }
      App.states[:motion_manager].startMagnetometerUpdatesToQueue NSOperationQueue.mainQueue, withHandler: handler
    end
  end

  def field_update(field)
    @on_update.call field unless @on_update.nil?
  end

  def on_update(&block)
    @on_update = block
  end

  def stop_updates
    @on_update = nil
  end
end

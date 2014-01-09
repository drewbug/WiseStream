class AccelerometerStreamer < BaseStreamer
  def __key__
    :accelerometer
  end

  def on_init
    @on_update = nil
  end

  def on_ready
    @oscillator = @audio_context.createOscillator
    @oscillator.connect @gain_node
    @oscillator.start(0)
    if App.states[:motion_manager].isAccelerometerAvailable
       handler = lambda { |data, error| acceleration_update(data.acceleration) }
      App.states[:motion_manager].startAccelerometerUpdatesToQueue NSOperationQueue.mainQueue, withHandler: handler
    end
  end

  def acceleration_update(acceleration)
    @on_update.call acceleration unless @on_update.nil?
  end

  def on_update(&block)
    @on_update = block
  end

  def stop_updates
    @on_update = nil
  end
end

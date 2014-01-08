class CompassStreamer < BaseStreamer
  def __key__
    :compass
  end

  def on_ready
    @oscillator = @audio_context.createOscillator
    @oscillator.connect @gain_node
    @oscillator.start(0)
  end
end

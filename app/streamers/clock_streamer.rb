class ClockStreamer < BaseStreamer
  def __key__
    :clock
  end

  def on_ready
    @oscillator = @audio_context.createOscillator
    @oscillator.connect @gain_node
    @oscillator.start(0)
  end
end

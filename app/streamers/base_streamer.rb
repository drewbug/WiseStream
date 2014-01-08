class BaseStreamer
  def initialize(audio_context)
    @audio_context = audio_context
    @audio_context.on_ready do
      @gain_node = @audio_context.createGain
      @gain_node.gain = App::Persistence[:"#{__key__}_volume"]
      @gain_node.connect(@audio_context.destination) if enabled?
      @oscillator = @audio_context.createOscillator
      @oscillator.connect @gain_node
      @oscillator.start(0)
    end
  end

  def volume
    @gain_node.gain
  end

  def volume=(value)
    App::Persistence[:"#{__key__}_volume"] = value
    @gain_node.gain = value
  end

  def enabled?
    App::Persistence[:"#{__key__}_enabled"]
  end

  def enabled=(value)
    App::Persistence[:"#{__key__}_enabled"] = value
    !!value ? @gain_node.connect(@audio_context.destination) : @gain_node.disconnect
  end
end

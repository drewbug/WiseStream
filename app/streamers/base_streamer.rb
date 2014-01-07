class BaseStreamer
  def initialize(audio_context)
    @audio_context = audio_context
    @audio_context.on_ready do
      @gain_node = @audio_context.createGain
      @gain_node.connect(@audio_context.destination) if enabled?
      @oscillator = @audio_context.createOscillator
      @oscillator.connect @gain_node
      @oscillator.start(0)
    end
  end

  def enabled?
    App::Persistence[:"#{__key__}_enabled"]
  end

  def enabled=(value)
    App::Persistence[:"#{__key__}_enabled"] = value
    if not @audio_context.locked
      if value == true then @gain_node.connect @audio_context.destination
      elsif value == false then @gain_node.disconnect end
    end
  end
end

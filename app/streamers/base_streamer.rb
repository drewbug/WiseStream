class BaseStreamer
  def initialize(audio_context)
    @audio_context = audio_context
    @audio_context.on_ready do
      @oscillator = @audio_context.createOscillator
      @oscillator.start(0)
      @oscillator.connect(@audio_context.destination) if enabled?
    end
  end

  def enabled?
    App::Persistence[:"#{__key__}_enabled"]
  end

  def enabled=(value)
    App::Persistence[:"#{__key__}_enabled"] = value
    if not @audio_context.locked
      if value == true then @oscillator.connect @audio_context.destination
      elsif value == false then @oscillator.disconnect end
    end
  end
end

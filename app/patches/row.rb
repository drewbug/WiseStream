module Formotion
  class Row
    def on_switch(&block)
      self.object.on_switch(&block)
    end
  end
end

class ClockScreen < PM::FormotionScreen
  title "Clock"

  def self.new(args = {})
    super.tap do |s|
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def table_data
    hash = { sections: [] }

    return hash
  end
end

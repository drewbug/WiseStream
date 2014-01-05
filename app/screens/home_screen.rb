class HomeScreen < PM::FormotionScreen
  title "WiseStream"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_tap { s.compass_tapped }
      s.form.sections[0].rows[1].on_tap { s.clock_tapped }
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Compass', key: :compass, type: :subform, image: 'compass' }
    hash[:sections][0][:rows][1] = { title: 'Clock', key: :clock, type: :subform, image: 'clock' }

    return hash
  end

  def compass_tapped
    open CompassScreen.new
  end

  def clock_tapped
    open ClockScreen.new
  end
end

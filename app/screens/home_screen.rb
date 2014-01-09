class HomeScreen < PM::FormotionScreen
  title "WiseStream"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_tap { s.general_tapped }
      s.form.sections[1].rows[0].on_tap { s.compass_tapped }
      s.form.sections[1].rows[1].on_tap { s.clock_tapped }
      s.form.sections[1].rows[2].on_tap { s.magnetometer_tapped }
      s.form.sections[1].rows[3].on_tap { s.accelerometer_tapped }
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'General', key: :general, type: :subform, image: 'general' }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'Compass', key: :compass, type: :subform, image: 'compass' }
    hash[:sections][1][:rows][1] = { title: 'Clock', key: :clock, type: :subform, image: 'clock' }
    hash[:sections][1][:rows][2] = { title: 'Magnetometer', key: :magnetometer, type: :subform, image: 'magnetometer' }
    hash[:sections][1][:rows][3] = { title: 'Accelerometer', key: :accelerometer, type: :subform, image: 'accelerometer' }

    return hash
  end

  def general_tapped
  end

  def compass_tapped
    open CompassScreen.new
  end

  def clock_tapped
    open ClockScreen.new
  end

  def magnetometer_tapped
    open MagnetometerScreen.new
  end

  def accelerometer_tapped
    open AccelerometerScreen.new
  end
end

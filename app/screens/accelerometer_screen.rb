class AccelerometerScreen < PM::FormotionScreen
  title "Accelerometer"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_switch { |v| s.enabled_switched(v) }
      s.form.sections[1].rows[0].on_slide { |v| s.volume_slid(v) }
      App.states[:accelerometer_streamer].on_update do |acceleration|
        s.form.sections[2].rows[0].value = acceleration.x
        s.form.sections[2].rows[1].value = acceleration.y
        s.form.sections[2].rows[2].value = acceleration.z
      end
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def will_dismiss
    App.states[:accelerometer_streamer].stop_updates
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Enabled?', key: :enabled, type: :switch, value: App::Persistence[:accelerometer_enabled] }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'Volume', key: :volume, type: :slider, range: (0..1), value: App::Persistence[:accelerometer_volume] }

    hash[:sections][2] = { rows: [] }
    hash[:sections][2][:rows][0] = { title: 'X', key: :field_x, type: :static }
    hash[:sections][2][:rows][1] = { title: 'Y', key: :field_y, type: :static }
    hash[:sections][2][:rows][2] = { title: 'Z', key: :field_z, type: :static }

    return hash
  end

  def enabled_switched(value)
    App.states[:accelerometer_streamer].enabled = value
  end

  def volume_slid(value)
    App.states[:accelerometer_streamer].volume = value
  end
end

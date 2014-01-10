class CompassScreen < PM::FormotionScreen
  title "Compass"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_switch { |v| s.enabled_switched(v) }
      s.form.sections[1].rows[0].on_slide { |v| s.volume_slid(v) }
      App.states[:compass_streamer].on_update do |heading|
        s.form.sections[2].rows[0].value = heading
      end
      s.form.sections[3].rows[0].on_input { |v| s.freq180_input(v) }
      s.form.sections[3].rows[1].on_input { |v| s.freq0360_input(v) }
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def will_dismiss
    App.states[:compass_streamer].stop_updates
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Enabled?', key: :enabled, type: :switch, value: App::Persistence[:compass_enabled] }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'Volume', key: :volume, type: :slider, range: (0..1), value: App::Persistence[:compass_volume] }

    hash[:sections][2] = { rows: [] }
    hash[:sections][2][:rows][0] = { title: 'Heading', key: :heading, type: :static }

    hash[:sections][3] = { rows: [] }
    hash[:sections][3][:rows][0] = { title: 'South (180°) Frequency', key: :freq180, type: :number, value: App::Persistence[:compass_freq180] }
    hash[:sections][3][:rows][1] = { title: 'North (0°/360°) Frequency', key: :freq0360, type: :number, value: App::Persistence[:compass_freq0360] }

    return hash
  end

  def enabled_switched(value)
    App.states[:compass_streamer].enabled = value
  end

  def volume_slid(value)
    App.states[:compass_streamer].volume = value
  end

  def freq180_input(value)
    App.states[:compass_streamer].freq180 = value
  end

  def freq0360_input(value)
    App.states[:compass_streamer].freq0360 = value
  end
end

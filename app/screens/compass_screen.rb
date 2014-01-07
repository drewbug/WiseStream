class CompassScreen < PM::FormotionScreen
  title "Compass"

  def self.new(args = {})
    super.tap do |s|
      s.form.sections[0].rows[0].on_switch { |v| s.enabled_switched(v) }
      s.form.sections[1].rows[0].on_slide { |v| s.volume_slid(v) }
    end
  end

  def on_load
    set_attributes self.view, { background_color: hex_color("EFEFF4") }
  end

  def table_data
    hash = { sections: [] }

    hash[:sections][0] = { rows: [] }
    hash[:sections][0][:rows][0] = { title: 'Enabled?', key: :enabled, type: :switch, value: App::Persistence[:compass_enabled] }

    hash[:sections][1] = { rows: [] }
    hash[:sections][1][:rows][0] = { title: 'Volume', key: :volume, type: :slider, range: (0..1), value: App::Persistence[:compass_volume] }

    return hash
  end

  def enabled_switched(value)
    App.states[:compass_streamer].enabled = value
  end

  def volume_slid(value)
    App.states[:compass_streamer].volume = value
  end
end

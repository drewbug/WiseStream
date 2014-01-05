class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    initialize_storage
    open HomeScreen.new(nav_bar: true)
  end

  def initialize_storage
    {}.each do |key, value|
      App::Persistence[key] = value if App::Persistence[key].nil?
    end
  end
end

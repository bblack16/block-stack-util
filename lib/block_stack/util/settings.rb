module BlockStack

  def self.settings
    @settings ||= default_settings
  end

  def self.setting(key)
    settings.hpath(key).first
  end

  def self.default_settings
    BBLib::HashStruct.new.tap do |settings|
      # No defaults yet
    end
  end

end

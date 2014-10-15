class TahiAnalytics
  class << self
    def track(args)
      return nil if Rails.analytics_enabled
      Analytics.track(args)
    end

    def identify(args)
      return nil if Rails.analytics_enabled
      Analytics.identify(args)
    end
  end
end

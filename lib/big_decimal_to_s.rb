# Only apply BigDecimal patch for Rails < 7.2
# Rails 7.2+ has ActiveSupport::BigDecimalWithDefaultFormat which conflicts
# Rails 4/5/6 need this patch for default format support

rails_version = defined?(Rails) && Rails.respond_to?(:version) ? Rails.version : nil
needs_patch = rails_version.nil? || Gem::Version.new(rails_version) < Gem::Version.new('7.2.0')

if needs_patch
  class BigDecimal

    def to_s_with_default_format(format = 'F')
      to_s_without_default_format(format)
    end
    alias_method :to_s_without_default_format, :to_s
    alias_method :to_s, :to_s_with_default_format

  end
end
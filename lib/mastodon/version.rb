# frozen_string_literal: true

module Mastodon
  module Version
    module_function

    def major
      2
    end

    def minor
      0
    end

    def patch
      0
    end

    def pre
      nil
    end

    def flags
      ''
    end

    def revision
      f = Rails.root.join('REVISION')
      f.readable? ? f.read(7) : nil
    end

    def to_a
      [major, minor, patch, pre].compact
    end

    def to_s
      [to_a.join('.'), flags, '-', revision].join
    end

    def source_base_url
      'https://github.com/esetomo/mastodon'
    end

    # specify git tag or commit hash here
    def source_tag
      'mayodon.club'
    end

    def source_url
      if source_tag
        "#{source_base_url}/tree/#{source_tag}"
      else
        source_base_url
      end
    end
  end
end

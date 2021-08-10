# typed: true
# frozen_string_literal: true

require "bundle_version"
require "unversioned_cask_checker"
require_relative "page_match"

module Homebrew
  module Livecheck
    module Strategy
      # The {ExtractPlist} strategy downloads the file at a URL and
      # extracts versions from contained `.plist` files.
      #
      # @api private
      class ExtractPlist
        extend T::Sig

        # A priority of zero causes livecheck to skip the strategy. We only
        # apply {ExtractPlist} using `strategy :extract_plist` in a `livecheck` block,
        # as we can't automatically determine when this can be successfully
        # applied to a URL without fetching the content.
        PRIORITY = 0

        # The `Regexp` used to determine if the strategy applies to the URL.
        URL_MATCH_REGEX = %r{^https?://}i.freeze

        # Whether the strategy can be applied to the provided URL.
        # The strategy will technically match any HTTP URL but is
        # only usable with a `livecheck` block containing a regex
        # or block.
        sig { params(url: String).returns(T::Boolean) }
        def self.match?(url)
          URL_MATCH_REGEX.match?(url)
        end

        # @api private
        Item = Struct.new(
          # @api private
          :bundle_version,
          keyword_init: true,
        ) do
          extend T::Sig

          extend Forwardable

          # @api public
          delegate version: :bundle_version

          # @api public
          delegate short_version: :bundle_version
        end

        # Identify versions from `Item`s produced using
        # {UnversionedCaskChecker} version information.
        #
        # @param items [Hash] a hash of `Item`s containing version information
        # @return [Array]
        sig {
          params(
            items: T::Hash[String, Item],
            block: T.nilable(
              T.proc.params(arg0: T::Hash[String, Item]).returns(T.any(String, T::Array[String], NilClass)),
            ),
          ).returns(T::Array[String])
        }
        def self.versions_from_items(items, &block)
          return Strategy.handle_block_return(block.call(items)) if block

          items.map do |_key, item|
            item.bundle_version.nice_version
          end.compact.uniq
        end

        # Uses {UnversionedCaskChecker} on the provided cask to identify
        # versions from `plist` files.
        sig {
          params(
            url:   String,
            regex: T.nilable(Regexp),
            cask:  Cask::Cask,
            block: T.nilable(
              T.proc.params(arg0: T::Hash[String, Item]).returns(T.any(String, T::Array[String], NilClass)),
            ),
          ).returns(T::Hash[Symbol, T.untyped])
        }
        def self.find_versions(url, regex, cask:, &block)
          raise ArgumentError, "The #{T.must(name).demodulize} strategy does not support a regex." if regex
          raise ArgumentError, "The #{T.must(name).demodulize} strategy only supports casks." unless T.unsafe(cask)

          match_data = { matches: {}, regex: regex, url: url }

          unversioned_cask_checker = UnversionedCaskChecker.new(cask)
          items = unversioned_cask_checker.all_versions.transform_values { |v| Item.new(bundle_version: v) }

          versions_from_items(items, &block).each do |version_text|
            match_data[:matches][version_text] = Version.new(version_text)
          end

          match_data
        end
      end
    end
  end
end

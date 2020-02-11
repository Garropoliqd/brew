# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      # Check for repeated describe and context block body.
      #
      # @example
      #
      #    # bad
      #    describe 'cool feature x' do
      #      it { cool_predicate }
      #    end
      #
      #    describe 'cool feature y' do
      #      it { cool_predicate }
      #    end
      #
      #    # good
      #    describe 'cool feature' do
      #      it { cool_predicate }
      #    end
      #
      #    describe 'another cool feature' do
      #      it { another_predicate }
      #    end
      #
      #    # good
      #    context 'when case x', :tag do
      #      it { cool_predicate }
      #    end
      #
      #    context 'when case y' do
      #      it { cool_predicate }
      #    end
      #
      class RepeatedExampleGroupBody < Cop
        MSG = 'Repeated %<group>s block body on line(s) %<loc>s'

        def_node_matcher :several_example_groups?, <<-PATTERN
          (begin <#example_group_with_body? #example_group_with_body? ...>)
        PATTERN

        def_node_matcher :metadata, '(block (send _ _ _ $...) ...)'
        def_node_matcher :body, '(block _ args $...)'

        def_node_matcher :skip_or_pending?, <<-PATTERN
          (block <(send nil? {:skip :pending}) ...>)
        PATTERN

        def on_begin(node)
          return unless several_example_groups?(node)

          repeated_group_bodies(node).each do |group, repeats|
            add_offense(group, message: message(group, repeats))
          end
        end

        private

        def repeated_group_bodies(node)
          node
            .children
            .select { |child| example_group_with_body?(child) }
            .reject { |child| skip_or_pending?(child) }
            .group_by { |group| signature_keys(group) }
            .values
            .reject(&:one?)
            .flat_map { |groups| add_repeated_lines(groups) }
        end

        def add_repeated_lines(groups)
          repeated_lines = groups.map(&:first_line)
          groups.map { |group| [group, repeated_lines - [group.first_line]] }
        end

        def signature_keys(group)
          [metadata(group), body(group)]
        end

        def message(group, repeats)
          format(MSG, group: group.method_name, loc: repeats)
        end
      end
    end
  end
end

# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails
      # This cop enforces that `ActiveRecord#find` is used instead of
      # `where.take!`, `find_by!`, and `find_by_id!` to retrieve a single record
      # by primary key when you expect it to be found.
      #
      # @example
      #   # bad
      #   User.where(id: id).take!
      #   User.find_by_id!(id)
      #   User.find_by!(id: id)
      #
      #   # good
      #   User.find(id)
      #
      class FindById < Cop
        include RangeHelp

        MSG = 'Use `%<good_method>s` instead of `%<bad_method>s`.'

        def_node_matcher :where_take?, <<~PATTERN
          (send
            $(send _ :where
              (hash
                (pair (sym :id) $_))) :take!)
        PATTERN

        def_node_matcher :find_by?, <<~PATTERN
          {
            (send _ :find_by_id! $_)
            (send _ :find_by! (hash (pair (sym :id) $_)))
          }
        PATTERN

        def on_send(node)
          where_take?(node) do |where, id_value|
            range = where_take_offense_range(node, where)

            good_method = build_good_method(id_value)
            bad_method = build_where_take_bad_method(id_value)
            message = format(MSG, good_method: good_method, bad_method: bad_method)

            add_offense(node, location: range, message: message)
          end

          find_by?(node) do |id_value|
            range = find_by_offense_range(node)

            good_method = build_good_method(id_value)
            bad_method = build_find_by_bad_method(node, id_value)
            message = format(MSG, good_method: good_method, bad_method: bad_method)

            add_offense(node, location: range, message: message)
          end
        end

        def autocorrect(node)
          if (matches = where_take?(node))
            where, id_value = *matches
            range = where_take_offense_range(node, where)
          elsif (id_value = find_by?(node))
            range = find_by_offense_range(node)
          end

          lambda do |corrector|
            replacement = build_good_method(id_value)
            corrector.replace(range, replacement)
          end
        end

        private

        def where_take_offense_range(node, where)
          range_between(where.loc.selector.begin_pos, node.loc.expression.end_pos)
        end

        def find_by_offense_range(node)
          range_between(node.loc.selector.begin_pos, node.loc.expression.end_pos)
        end

        def build_good_method(id_value)
          "find(#{id_value.source})"
        end

        def build_where_take_bad_method(id_value)
          "where(id: #{id_value.source}).take!"
        end

        def build_find_by_bad_method(node, id_value)
          case node.method_name
          when :find_by_id!
            "find_by_id!(#{id_value.source})"
          when :find_by!
            "find_by!(id: #{id_value.source})"
          end
        end
      end
    end
  end
end

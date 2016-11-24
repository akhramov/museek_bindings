module Support
  module Expectations
    def must_be_length_of(length)
      ctx.assert_equal(target.length, length)
    end

    def must_have_keys(*keys)
      difference = keys - target.keys

      ctx.assert(difference.empty?, "Expected #{target} to have #{difference} keys.")
    end

    def must_be_true
      ctx.assert(target == true)
    end

    def wont_be_true
      ctx.refute(target == true)
    end
  end
end

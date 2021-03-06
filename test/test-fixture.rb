class TestUnitFixture < Test::Unit::TestCase
  module EmptyModule
  end

  def test_setup_without_option
    expected_setup_calls = [:setup,
                            :custom_setup_method0,
                            :custom_setup_method1,
                            :custom_setup_method3]
    test_case = assert_setup(expected_setup_calls, [])
    assert_inherited_setup(expected_setup_calls, test_case)

    assert_inherited_setup([:setup], nil)
    assert_called_fixtures(expected_setup_calls, test_case)
  end

  def test_setup_with_before_option
    expected_setup_calls = [:custom_setup_method3,
                            :custom_setup_method0,
                            :custom_setup_method1,
                            :setup]
    test_case = assert_setup(expected_setup_calls,
                             [[{:before => :append}],
                              [{:before => :append}],
                              [{:before => :prepend}],
                              [{:before => :prepend}]])
    assert_inherited_setup(expected_setup_calls, test_case)

    assert_inherited_setup([:setup], nil)
    assert_called_fixtures(expected_setup_calls, test_case)
  end

  def test_setup_with_after_option
    expected_setup_calls = [:setup,
                            :custom_setup_method3,
                            :custom_setup_method0,
                            :custom_setup_method1]
    test_case = assert_setup(expected_setup_calls,
                             [[{:after => :append}],
                              [{:after => :append}],
                              [{:after => :prepend}],
                              [{:after => :prepend}]])
    assert_inherited_setup(expected_setup_calls, test_case)

    assert_inherited_setup([:setup], nil)
    assert_called_fixtures(expected_setup_calls, test_case)
  end

  def test_setup_with_invalid_option
    assert_invalid_setup_option(:unknown => true)
    assert_invalid_setup_option(:before => :unknown)
    assert_invalid_setup_option(:after => :unknown)
  end

  def test_setup_with_option_to_inherited
    expected_setup_calls = [:setup]
    test_case = assert_setup(expected_setup_calls, nil)
    assert_inherited_setup([:setup,
                            :custom_setup_method0,
                            :custom_setup_method1,
                            :custom_setup_method3],
                           test_case,
                           [])

    assert_inherited_setup([:setup], nil)
    assert_called_fixtures(expected_setup_calls, test_case)
  end

  def test_cleanup_without_option
    expected_cleanup_calls = [:custom_cleanup_method3,
                              :custom_cleanup_method1,
                              :custom_cleanup_method0,
                              :cleanup]
    test_case = assert_cleanup(expected_cleanup_calls, [])
    assert_inherited_cleanup(expected_cleanup_calls, test_case)

    assert_inherited_cleanup([:cleanup], nil)
    assert_called_fixtures(expected_cleanup_calls, test_case)
  end

  def test_cleanup_with_before_option
    expected_cleanup_calls = [:custom_cleanup_method3,
                              :custom_cleanup_method0,
                              :custom_cleanup_method1,
                              :cleanup]
    test_case = assert_cleanup(expected_cleanup_calls,
                                [[{:before => :append}],
                                 [{:before => :append}],
                                 [{:before => :prepend}],
                                 [{:before => :prepend}]])
    assert_inherited_cleanup(expected_cleanup_calls, test_case)

    assert_inherited_cleanup([:cleanup], nil)
    assert_called_fixtures(expected_cleanup_calls, test_case)
  end

  def test_cleanup_with_after_option
    expected_cleanup_calls = [:cleanup,
                              :custom_cleanup_method3,
                              :custom_cleanup_method0,
                              :custom_cleanup_method1]
    test_case = assert_cleanup(expected_cleanup_calls,
                                [[{:after => :append}],
                                 [{:after => :append}],
                                 [{:after => :prepend}],
                                 [{:after => :prepend}]])
    assert_inherited_cleanup(expected_cleanup_calls, test_case)

    assert_inherited_cleanup([:cleanup], nil)
    assert_called_fixtures(expected_cleanup_calls, test_case)
  end

  def test_cleanup_with_invalid_option
    assert_invalid_cleanup_option(:unknown => true)
    assert_invalid_cleanup_option(:before => :unknown)
    assert_invalid_cleanup_option(:after => :unknown)
  end

  def test_cleanup_with_option_to_inherited
    expected_cleanup_calls = [:cleanup]
    test_case = assert_cleanup(expected_cleanup_calls, nil)
    assert_inherited_cleanup([:custom_cleanup_method3,
                              :custom_cleanup_method1,
                              :custom_cleanup_method0,
                              :cleanup],
                              test_case, [])

    assert_inherited_cleanup([:cleanup], nil)
    assert_called_fixtures(expected_cleanup_calls, test_case)
  end

  def test_cleanup_with_exception
    test_case = Class.new(Test::Unit::TestCase) do
      def called_ids
        @called_ids ||= []
      end

      def called(id)
        called_ids << id
      end

      def cleanup
        called(:cleanup)
        raise "cleanup"
      end

      cleanup
      def custom_cleanup_method0
        called(:custom_cleanup_method0)
        raise "custom_cleanup_method0"
      end

      cleanup
      def custom_cleanup_method1
        called(:custom_cleanup_method1)
        raise "custom_cleanup_method1"
      end

      def test_nothing
      end
    end

    assert_called_fixtures([:custom_cleanup_method1],
                           test_case)
  end

  def test_teardown_without_option
    expected_teardown_calls = [:custom_teardown_method3,
                               :custom_teardown_method1,
                               :custom_teardown_method0,
                               :teardown]
    test_case = assert_teardown(expected_teardown_calls, [])
    assert_inherited_teardown(expected_teardown_calls, test_case)

    assert_inherited_teardown([:teardown], nil)
    assert_called_fixtures(expected_teardown_calls, test_case)
  end

  def test_teardown_with_before_option
    expected_teardown_calls = [:custom_teardown_method3,
                               :custom_teardown_method0,
                               :custom_teardown_method1,
                               :teardown]
    test_case = assert_teardown(expected_teardown_calls,
                                [[{:before => :append}],
                                 [{:before => :append}],
                                 [{:before => :prepend}],
                                 [{:before => :prepend}]])
    assert_inherited_teardown(expected_teardown_calls, test_case)

    assert_inherited_teardown([:teardown], nil)
    assert_called_fixtures(expected_teardown_calls, test_case)
  end

  def test_teardown_with_after_option
    expected_teardown_calls = [:teardown,
                               :custom_teardown_method3,
                               :custom_teardown_method0,
                               :custom_teardown_method1]
    test_case = assert_teardown(expected_teardown_calls,
                                [[{:after => :append}],
                                 [{:after => :append}],
                                 [{:after => :prepend}],
                                 [{:after => :prepend}]])
    assert_inherited_teardown(expected_teardown_calls, test_case)

    assert_inherited_teardown([:teardown], nil)
    assert_called_fixtures(expected_teardown_calls, test_case)
  end

  def test_teardown_with_invalid_option
    assert_invalid_teardown_option(:unknown => true)
    assert_invalid_teardown_option(:before => :unknown)
    assert_invalid_teardown_option(:after => :unknown)
  end

  def test_teardown_with_option_to_inherited
    expected_teardown_calls = [:teardown]
    test_case = assert_teardown(expected_teardown_calls, nil)
    assert_inherited_teardown([:custom_teardown_method3,
                               :custom_teardown_method1,
                               :custom_teardown_method0,
                               :teardown],
                              test_case, [])

    assert_inherited_teardown([:teardown], nil)
    assert_called_fixtures(expected_teardown_calls, test_case)
  end

  def test_teardown_with_exception
    test_case = Class.new(Test::Unit::TestCase) do
      def called_ids
        @called_ids ||= []
      end

      def called(id)
        called_ids << id
      end

      def teardown
        called(:teardown)
        raise "teardown"
      end

      teardown
      def custom_teardown_method0
        called(:custom_teardown_method0)
        raise "custom_teardown_method0"
      end

      teardown
      def custom_teardown_method1
        called(:custom_teardown_method1)
        raise "custom_teardown_method1"
      end

      def test_nothing
      end
    end

    assert_called_fixtures([:custom_teardown_method1,
                            :custom_teardown_method0,
                            :teardown],
                           test_case)
  end

  private
  def assert_called_fixtures(expected, test_case)
    test = test_case.new("test_nothing")
    test.run(Test::Unit::TestResult.new) {}
    assert_equal(expected, test.called_ids)
  end

  def assert_setup_customizable(expected, parent, options)
    test_case = Class.new(parent || Test::Unit::TestCase) do
      yield(self, :before) if block_given?

      def called_ids
        @called_ids ||= []
      end

      def called(id)
        called_ids << id
      end

      def setup
        called(:setup)
      end

      setup(*(options[0] || [])) if options
      def custom_setup_method0
        called(:custom_setup_method0)
      end

      def custom_setup_method1
        called(:custom_setup_method1)
      end
      setup(*[:custom_setup_method1, *(options[1] || [])]) if options

      setup(*(options[2] || [])) if options
      def custom_setup_method2
        called(:custom_setup_method2)
      end
      unregister_setup(:custom_setup_method2) if options

      setup(*(options[3] || [])) if options
      def custom_setup_method3
        called(:custom_setup_method3)
      end

      def test_nothing
      end

      yield(self, :after) if block_given?
    end

    assert_called_fixtures(expected, test_case)
    test_case
  end

  def assert_setup(expected, options)
    _test_case = assert_setup_customizable(expected, nil, options)
    assert_setup_customizable(expected, nil, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
    _test_case
  end

  def assert_inherited_setup(expected, parent, options=nil)
    _test_case = assert_setup_customizable(expected, parent, options)
    assert_setup_customizable(expected, parent, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
    _test_case
  end

  def assert_cleanup_customizable(expected, parent, options)
    test_case = Class.new(parent || Test::Unit::TestCase) do
      yield(self, :before) if block_given?

      def called_ids
        @called_ids ||= []
      end

      def called(id)
        called_ids << id
      end

      def cleanup
        called(:cleanup)
      end

      cleanup(*(options[0] || [])) if options
      def custom_cleanup_method0
        called(:custom_cleanup_method0)
      end

      def custom_cleanup_method1
        called(:custom_cleanup_method1)
      end
      cleanup(*[:custom_cleanup_method1, *(options[1] || [])]) if options

      cleanup(*(options[2] || [])) if options
      def custom_cleanup_method2
        called(:custom_cleanup_method2)
      end
      unregister_cleanup(:custom_cleanup_method2) if options

      cleanup(*(options[3] || [])) if options
      def custom_cleanup_method3
        called(:custom_cleanup_method3)
      end

      def test_nothing
      end

      yield(self, :after) if block_given?
    end

    assert_called_fixtures(expected, test_case)
    test_case
  end

  def assert_cleanup(expected, options)
    assert_cleanup_customizable(expected, nil, options)
    assert_cleanup_customizable(expected, nil, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
  end

  def assert_inherited_cleanup(expected, parent, options=nil)
    assert_cleanup_customizable(expected, parent, options)
    assert_cleanup_customizable(expected, parent, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
  end

  def assert_teardown_customizable(expected, parent, options)
    test_case = Class.new(parent || Test::Unit::TestCase) do
      yield(self, :before) if block_given?

      def called_ids
        @called_ids ||= []
      end

      def called(id)
        called_ids << id
      end

      def teardown
        called(:teardown)
      end

      teardown(*(options[0] || [])) if options
      def custom_teardown_method0
        called(:custom_teardown_method0)
      end

      def custom_teardown_method1
        called(:custom_teardown_method1)
      end
      teardown(*[:custom_teardown_method1, *(options[1] || [])]) if options

      teardown(*(options[2] || [])) if options
      def custom_teardown_method2
        called(:custom_teardown_method2)
      end
      unregister_teardown(:custom_teardown_method2) if options

      teardown(*(options[3] || [])) if options
      def custom_teardown_method3
        called(:custom_teardown_method3)
      end

      def test_nothing
      end

      yield(self, :after) if block_given?
    end

    assert_called_fixtures(expected, test_case)
    test_case
  end

  def assert_teardown(expected, options)
    assert_teardown_customizable(expected, nil, options)
    assert_teardown_customizable(expected, nil, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
  end

  def assert_inherited_teardown(expected, parent, options=nil)
    assert_teardown_customizable(expected, parent, options)
    assert_teardown_customizable(expected, parent, options) do |test_case, tag|
      test_case.send(:include, EmptyModule) if tag == :before
    end
  end

  def assert_invalid_option(fixture_type, option)
    exception = assert_raise(ArgumentError) do
      Class.new(Test::Unit::TestCase) do
        def test_nothing
        end

        send(fixture_type, option)
        def fixture
        end
      end
    end
    assert_equal("must be {:before => :prepend}, {:before => :append}, " +
                 "{:after => :prepend} or {:after => :append}" +
                 ": #{option.inspect}",
                 exception.message)
  end

  def assert_invalid_setup_option(option)
    assert_invalid_option(:setup, option)
  end

  def assert_invalid_cleanup_option(option)
    assert_invalid_option(:cleanup, option)
  end

  def assert_invalid_teardown_option(option)
    assert_invalid_option(:teardown, option)
  end
end

module Support
  module FixtureLoader
    module_function

    def call(name)
      File.read(File.join(__dir__, 'fixtures', name)).force_encoding('ASCII-8BIT')
    end
  end
end

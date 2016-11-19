module Helpers
  class Image
    def self.sample_image
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/fixtures/rails.png'))
    end
  end
end

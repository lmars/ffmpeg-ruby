require "spec_helper"

describe FFmpeg::File do
  let(:filepath) { "#{root}/spec/fixtures/#{filename}" }

  subject { FFmpeg::File.new(filepath) }

  describe "format_name" do
    context "WMV" do
      let(:filename) { "ruby-logo.msmpeg4.480x480.wmv" }

      its(:format_name) { should match(/^ASF/) }
    end
  end
end

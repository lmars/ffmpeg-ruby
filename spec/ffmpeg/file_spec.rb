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

  describe "streams" do
    let(:filename) { "ruby-logo.msmpeg4.480x480.wmv" }
    let(:stream) { { "type" => "video", "codec" => "msmpeg4v3" } }

    its(:streams) { should == [stream] }
  end
end

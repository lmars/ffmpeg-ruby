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
    let(:stream) do
      {
        "type"     => "video",
        "codec"    => "msmpeg4v3",
        "duration" => 1.0,
        "width"    => 480,
        "height"   => 480
      }
    end

    its(:streams) { should == [stream] }
  end
end

require "spec_helper"

describe FFmpeg::File do
  let(:filename) { "ruby-logo.h264.480x480.mp4" }
  let(:filepath) { "#{root}/spec/fixtures/#{filename}" }

  subject { FFmpeg::File.new(filepath) }

  its(:video_codec) { should == "h264" }

  describe "format_name" do
    its(:format_name) { should match(/^QuickTime/) }

    context "WMV" do
      let(:filename) { "ruby-logo.msmpeg4.480x480.wmv" }

      its(:format_name) { should match(/^ASF/) }
    end

    context "AVI" do
      let(:filename) { "ruby-logo.h264.480x480.avi" }

      its(:format_name) { should match(/^AVI/) }
    end
  end

  describe "streams" do
    let(:stream) do
      {
        "type"     => "video",
        "codec"    => "h264",
        "duration" => 1.0,
        "width"    => 480,
        "height"   => 480
      }
    end

    its(:streams) { should == [stream] }

    context "WMV" do
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

    context "AVI" do
      let(:filename) { "ruby-logo.h264.480x480.avi" }
      let(:stream) do
        {
          "type"     => "video",
          "codec"    => "h264",
          "duration" => 1.0,
          "width"    => 480,
          "height"   => 480
        }
      end

      its(:streams) { should == [stream] }
    end
  end
end

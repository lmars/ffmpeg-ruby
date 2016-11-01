module FFmpeg
  class File
    def initialize(filepath)
      @filepath = filepath
    end

    def format_name
      fileinfo["format_name"]
    end

    def streams
      fileinfo["streams"]
    end

    def video_codec
      video_stream["codec"]
    end

    def video_duration
      video_stream["duration"]
    end

    def video_frames
      video_stream["frames"]
    end

    def video_frame_rate
      video_stream["frame_rate"]
    end

    def video_width
      video_stream["width"]
    end

    def video_height
      video_stream["height"]
    end

    private
    def fileinfo
      @fileinfo ||= FFmpeg.get_file_info(@filepath)
    end

    def video_stream
      streams.detect { |s| s["type"] == "video" }
    end
  end
end

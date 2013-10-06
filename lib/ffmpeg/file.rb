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

    private
    def fileinfo
      @fileinfo ||= FFmpeg.get_file_info(@filepath)
    end

    def video_stream
      streams.detect { |s| s["type"] == "video" }
    end
  end
end

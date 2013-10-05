module FFmpeg
  class File
    def initialize(filepath)
      @filepath = filepath
    end

    def format_name
      fileinfo["format_name"]
    end

    private
    def fileinfo
      @fileinfo ||= FFmpeg.get_file_info(@filepath)
    end
  end
end

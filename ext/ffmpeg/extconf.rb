require "mkmf"

def fail_with_error(msg)
  abort <<-EOS
  -----
  ERROR
  -----
  #{msg}

  EOS
end

unless have_header("libavformat/avformat.h")
  fail_with_error "libavformat/avformat.h is missing. You should install the libavformat header files"
end

unless have_library("avformat", "av_register_all")
  fail_with_error "libavformat is missing. You should install the libavformat library"
end

create_makefile("ffmpeg")

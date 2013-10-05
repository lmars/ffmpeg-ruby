#include "ruby.h"
#include <libavformat/avformat.h>

VALUE ffmpeg_get_file_info(VALUE self, VALUE filepath) {
  AVFormatContext *av_context;
  VALUE fileinfo;

  av_context = avformat_alloc_context();
  if(!av_context) {
    rb_raise(rb_eRuntimeError, "error in avformat_alloc_context()");
  }

  if(avformat_open_input(&av_context, StringValueCStr(filepath), NULL, NULL) != 0) {
    rb_raise(rb_eRuntimeError, "error in avformat_open_input()");
  }

  if(avformat_find_stream_info(av_context, NULL) < 0) {
    rb_raise(rb_eRuntimeError, "error in avformat_find_stream_info()");
  }

  fileinfo = rb_hash_new();
  rb_hash_aset(fileinfo, rb_str_new2("format_name"), rb_str_new2(av_context->iformat->long_name));

  return fileinfo;
}

VALUE mFFmpeg;

void Init_ffmpeg() {
  av_register_all();
  mFFmpeg = rb_define_module("FFmpeg");
  rb_define_module_function(mFFmpeg, "get_file_info", ffmpeg_get_file_info, 1);
}

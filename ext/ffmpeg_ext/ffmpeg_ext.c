#include "ruby.h"
#include <libavformat/avformat.h>
#include <libavutil/avutil.h>

VALUE ffmpeg_get_file_info(VALUE self, VALUE filepath) {
  AVFormatContext *av_context;
  AVStream *av_stream;
  VALUE fileinfo;
  VALUE streams;
  VALUE stream;
  VALUE media_type;
  VALUE codec_name;
  double duration;
  int i;

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

  streams = rb_ary_new2(av_context->nb_streams);
  for(i = 0; i < av_context->nb_streams; i++) {
    av_stream = av_context->streams[i];
    stream = rb_hash_new();

    media_type = rb_str_new2(av_get_media_type_string(av_stream->codec->codec_type));
    rb_hash_aset(stream, rb_str_new2("type"), media_type);

    codec_name = rb_str_new2(avcodec_get_name(av_stream->codec->codec_id));
    rb_hash_aset(stream, rb_str_new2("codec"), codec_name);

    duration = av_stream->duration * av_q2d(av_stream->time_base);
    rb_hash_aset(stream, rb_str_new2("duration"), rb_float_new(duration));

    rb_hash_aset(stream, rb_str_new2("width"), INT2NUM(av_stream->codec->width));
    rb_hash_aset(stream, rb_str_new2("height"), INT2NUM(av_stream->codec->height));

    rb_ary_push(streams, stream);
  }
  rb_hash_aset(fileinfo, rb_str_new2("streams"), streams);

  avformat_close_input(&av_context);
  avformat_free_context(av_context);

  return fileinfo;
}

VALUE mFFmpeg;

void Init_ffmpeg_ext() {
  av_register_all();
  mFFmpeg = rb_define_module("FFmpeg");
  rb_define_module_function(mFFmpeg, "get_file_info", ffmpeg_get_file_info, 1);
}

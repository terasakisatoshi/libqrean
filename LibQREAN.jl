module LibQREAN

libqrean = "src/libqrean.so"

using CEnum

const uint_fast8_t = UInt8

const uint_fast16_t = UInt16

const uint_fast32_t = UInt32

const bit_t = uint_fast8_t

const bitpos_t = uint_fast32_t

# typedef bitpos_t ( * bitstream_iterator_t ) ( bitstream_t * bs , bitpos_t pos , void * opaque )
const bitstream_iterator_t = Ptr{Cvoid}

# typedef void ( * bitstream_write_bit_callback_t ) ( bitstream_t * bs , bitpos_t pos , void * opaque , bit_t v )
const bitstream_write_bit_callback_t = Ptr{Cvoid}

# typedef bit_t ( * bitstream_read_bit_callback_t ) ( bitstream_t * bs , bitpos_t pos , void * opaque )
const bitstream_read_bit_callback_t = Ptr{Cvoid}

struct _bitstream_t
    size::bitpos_t
    bits::Ptr{UInt8}
    pos::bitpos_t
    iter::bitstream_iterator_t
    opaque::Ptr{Cvoid}
    write_bit_at::bitstream_write_bit_callback_t
    opaque_write::Ptr{Cvoid}
    read_bit_at::bitstream_read_bit_callback_t
    opaque_read::Ptr{Cvoid}
end

const bitstream_t = _bitstream_t

function bitstream_init(bs, src, len, iter, opaque)
    ccall((:bitstream_init, libqrean), Cvoid, (Ptr{bitstream_t}, Ptr{Cvoid}, bitpos_t, bitstream_iterator_t, Ptr{Cvoid}), bs, src, len, iter, opaque)
end

function create_bitstream(src, len, iter, opaque)
    ccall((:create_bitstream, libqrean), bitstream_t, (Ptr{Cvoid}, bitpos_t, bitstream_iterator_t, Ptr{Cvoid}), src, len, iter, opaque)
end

function bitstream_fill(bs, v)
    ccall((:bitstream_fill, libqrean), Cvoid, (Ptr{bitstream_t}, bit_t), bs, v)
end

function bitstream_length(bs)
    ccall((:bitstream_length, libqrean), bitpos_t, (Ptr{bitstream_t},), bs)
end

function bitstream_dump(bs, len, out)
    ccall((:bitstream_dump, libqrean), Cvoid, (Ptr{bitstream_t}, bitpos_t, Ptr{Libc.FILE}), bs, len, out)
end

function bitstream_read_bit(bs)
    ccall((:bitstream_read_bit, libqrean), bit_t, (Ptr{bitstream_t},), bs)
end

function bitstream_peek_bit(bs, pos)
    ccall((:bitstream_peek_bit, libqrean), bit_t, (Ptr{bitstream_t}, Ptr{bitpos_t}), bs, pos)
end

function bitstream_read_bits(bs, num_bits)
    ccall((:bitstream_read_bits, libqrean), uint_fast32_t, (Ptr{bitstream_t}, uint_fast8_t), bs, num_bits)
end

function bitstream_peek_bits(bs, num_bits)
    ccall((:bitstream_peek_bits, libqrean), uint_fast32_t, (Ptr{bitstream_t}, uint_fast8_t), bs, num_bits)
end

function bitstream_skip_bits(bs, num_bits)
    ccall((:bitstream_skip_bits, libqrean), uint_fast8_t, (Ptr{bitstream_t}, uint_fast8_t), bs, num_bits)
end

function bitstream_write_bit(bs, bit)
    ccall((:bitstream_write_bit, libqrean), bit_t, (Ptr{bitstream_t}, bit_t), bs, bit)
end

function bitstream_write_bits(bs, value, num_bits)
    ccall((:bitstream_write_bits, libqrean), bit_t, (Ptr{bitstream_t}, uint_fast32_t, uint_fast8_t), bs, value, num_bits)
end

function bitstream_seek(bs, pos)
    ccall((:bitstream_seek, libqrean), Cvoid, (Ptr{bitstream_t}, bitpos_t), bs, pos)
end

function bitstream_rewind(bs)
    ccall((:bitstream_rewind, libqrean), Cvoid, (Ptr{bitstream_t},), bs)
end

function bitstream_tell(bs)
    ccall((:bitstream_tell, libqrean), bitpos_t, (Ptr{bitstream_t},), bs)
end

function bitstream_loop_iter(bs, i, opaque)
    ccall((:bitstream_loop_iter, libqrean), bitpos_t, (Ptr{bitstream_t}, bitpos_t, Ptr{Cvoid}), bs, i, opaque)
end

function bitstream_write(dst, buffer, size, n)
    ccall((:bitstream_write, libqrean), bitpos_t, (Ptr{bitstream_t}, Ptr{Cvoid}, bitpos_t, bitpos_t), dst, buffer, size, n)
end

function bitstream_read(src, buffer, size, n)
    ccall((:bitstream_read, libqrean), bitpos_t, (Ptr{bitstream_t}, Ptr{Cvoid}, bitpos_t, bitpos_t), src, buffer, size, n)
end

function bitstream_copy(dst, src, size, n)
    ccall((:bitstream_copy, libqrean), bitpos_t, (Ptr{bitstream_t}, Ptr{bitstream_t}, bitpos_t, bitpos_t), dst, src, size, n)
end

function bitstream_is_end(bs)
    ccall((:bitstream_is_end, libqrean), bit_t, (Ptr{bitstream_t},), bs)
end

function bitstream_on_write_bit(bs, cb, opaque)
    ccall((:bitstream_on_write_bit, libqrean), Cvoid, (Ptr{bitstream_t}, bitstream_write_bit_callback_t, Ptr{Cvoid}), bs, cb, opaque)
end

function bitstream_on_read_bit(bs, cb, opaque)
    ccall((:bitstream_on_read_bit, libqrean), Cvoid, (Ptr{bitstream_t}, bitstream_read_bit_callback_t, Ptr{Cvoid}), bs, cb, opaque)
end

@cenum qr_version_t::Int32 begin
    QR_VERSION_INVALID = -1
    QR_VERSION_AUTO = 0
    QR_VERSION_1 = 1
    QR_VERSION_2 = 2
    QR_VERSION_3 = 3
    QR_VERSION_4 = 4
    QR_VERSION_5 = 5
    QR_VERSION_6 = 6
    QR_VERSION_7 = 7
    QR_VERSION_8 = 8
    QR_VERSION_9 = 9
    QR_VERSION_10 = 10
    QR_VERSION_11 = 11
    QR_VERSION_12 = 12
    QR_VERSION_13 = 13
    QR_VERSION_14 = 14
    QR_VERSION_15 = 15
    QR_VERSION_16 = 16
    QR_VERSION_17 = 17
    QR_VERSION_18 = 18
    QR_VERSION_19 = 19
    QR_VERSION_20 = 20
    QR_VERSION_21 = 21
    QR_VERSION_22 = 22
    QR_VERSION_23 = 23
    QR_VERSION_24 = 24
    QR_VERSION_25 = 25
    QR_VERSION_26 = 26
    QR_VERSION_27 = 27
    QR_VERSION_28 = 28
    QR_VERSION_29 = 29
    QR_VERSION_30 = 30
    QR_VERSION_31 = 31
    QR_VERSION_32 = 32
    QR_VERSION_33 = 33
    QR_VERSION_34 = 34
    QR_VERSION_35 = 35
    QR_VERSION_36 = 36
    QR_VERSION_37 = 37
    QR_VERSION_38 = 38
    QR_VERSION_39 = 39
    QR_VERSION_40 = 40
    QR_VERSION_M1 = 41
    QR_VERSION_M2 = 42
    QR_VERSION_M3 = 43
    QR_VERSION_M4 = 44
    QR_VERSION_R7x43 = 45
    QR_VERSION_R7x59 = 46
    QR_VERSION_R7x77 = 47
    QR_VERSION_R7x99 = 48
    QR_VERSION_R7x139 = 49
    QR_VERSION_R9x43 = 50
    QR_VERSION_R9x59 = 51
    QR_VERSION_R9x77 = 52
    QR_VERSION_R9x99 = 53
    QR_VERSION_R9x139 = 54
    QR_VERSION_R11x27 = 55
    QR_VERSION_R11x43 = 56
    QR_VERSION_R11x59 = 57
    QR_VERSION_R11x77 = 58
    QR_VERSION_R11x99 = 59
    QR_VERSION_R11x139 = 60
    QR_VERSION_R13x27 = 61
    QR_VERSION_R13x43 = 62
    QR_VERSION_R13x59 = 63
    QR_VERSION_R13x77 = 64
    QR_VERSION_R13x99 = 65
    QR_VERSION_R13x139 = 66
    QR_VERSION_R15x43 = 67
    QR_VERSION_R15x59 = 68
    QR_VERSION_R15x77 = 69
    QR_VERSION_R15x99 = 70
    QR_VERSION_R15x139 = 71
    QR_VERSION_R17x43 = 72
    QR_VERSION_R17x59 = 73
    QR_VERSION_R17x77 = 74
    QR_VERSION_R17x99 = 75
    QR_VERSION_R17x139 = 76
    QR_VERSION_TQR = 77
end

@cenum qr_errorlevel_t::Int32 begin
    QR_ERRORLEVEL_INVALID = -1
    QR_ERRORLEVEL_L = 0
    QR_ERRORLEVEL_M = 1
    QR_ERRORLEVEL_Q = 2
    QR_ERRORLEVEL_H = 3
end

@cenum qr_maskpattern_t::Int32 begin
    QR_MASKPATTERN_INVALID = -1
    QR_MASKPATTERN_0 = 0
    QR_MASKPATTERN_1 = 1
    QR_MASKPATTERN_2 = 2
    QR_MASKPATTERN_3 = 3
    QR_MASKPATTERN_4 = 4
    QR_MASKPATTERN_5 = 5
    QR_MASKPATTERN_6 = 6
    QR_MASKPATTERN_7 = 7
    QR_MASKPATTERN_NONE = 8
    QR_MASKPATTERN_ALL = 9
    QR_MASKPATTERN_AUTO = 10
end

struct qrformat_t
    version::qr_version_t
    mask::qr_maskpattern_t
    level::qr_errorlevel_t
    value::UInt32
end

function qrformat_for(version, level, mask)
    ccall((:qrformat_for, libqrean), qrformat_t, (qr_version_t, qr_errorlevel_t, qr_maskpattern_t), version, level, mask)
end

function qrformat_from(version, value)
    ccall((:qrformat_from, libqrean), qrformat_t, (qr_version_t, UInt32), version, value)
end

struct qrdata_t
    bs::bitstream_t
    version::qr_version_t
    debug::Cint
end

@cenum qr_data_mode_t::UInt32 begin
    QR_DATA_MODE_ECI = 7
    QR_DATA_MODE_NUMERIC = 1
    QR_DATA_MODE_ALNUM = 2
    QR_DATA_MODE_8BIT = 4
    QR_DATA_MODE_KANJI = 8
    QR_DATA_MODE_FNC1_1 = 5
    QR_DATA_MODE_FNC1_2 = 9
    QR_DATA_MODE_STRUCTURED = 3
    QR_DATA_MODE_END = 0
    QR_DATA_MODE_AUTO = 255
end

function create_qrdata_for(bs, version)
    ccall((:create_qrdata_for, libqrean), qrdata_t, (bitstream_t, qr_version_t), bs, version)
end

function new_qrdata_for(bs, version)
    ccall((:new_qrdata_for, libqrean), Ptr{qrdata_t}, (bitstream_t, qr_version_t), bs, version)
end

function qrdata_free(data)
    ccall((:qrdata_free, libqrean), Cvoid, (Ptr{qrdata_t},), data)
end

# typedef size_t ( * qrdata_writer_t ) ( qrdata_t * data , const char * src , size_t len )
const qrdata_writer_t = Ptr{Cvoid}

function qrdata_write_8bit_string(data, src, len)
    ccall((:qrdata_write_8bit_string, libqrean), Csize_t, (Ptr{qrdata_t}, Ptr{Cchar}, Csize_t), data, src, len)
end

function qrdata_write_numeric_string(data, src, len)
    ccall((:qrdata_write_numeric_string, libqrean), Csize_t, (Ptr{qrdata_t}, Ptr{Cchar}, Csize_t), data, src, len)
end

function qrdata_write_alnum_string(data, src, len)
    ccall((:qrdata_write_alnum_string, libqrean), Csize_t, (Ptr{qrdata_t}, Ptr{Cchar}, Csize_t), data, src, len)
end

function qrdata_write_string(data, src, len)
    ccall((:qrdata_write_string, libqrean), Csize_t, (Ptr{qrdata_t}, Ptr{Cchar}, Csize_t), data, src, len)
end

function qrdata_finalize(data)
    ccall((:qrdata_finalize, libqrean), bit_t, (Ptr{qrdata_t},), data)
end

function qrdata_parse(data, on_letter_cb, opaque)
    ccall((:qrdata_parse, libqrean), Csize_t, (Ptr{qrdata_t}, Ptr{Cvoid}, Ptr{Cvoid}), data, on_letter_cb, opaque)
end

struct qrpayload_t
    version::qr_version_t
    level::qr_errorlevel_t
    data_words::bitpos_t
    error_words::bitpos_t
    total_words::bitpos_t
    total_bits::bitpos_t
    data_bits::bitpos_t
    word_size::bitpos_t
    small_blocks::bitpos_t
    large_blocks::bitpos_t
    total_blocks::bitpos_t
    data_words_in_small_block::bitpos_t
    data_words_in_large_block::bitpos_t
    error_words_in_block::bitpos_t
    total_words_in_small_block::bitpos_t
    total_words_in_large_block::bitpos_t
    buffer::NTuple{3706, UInt8}
end

function qrpayload_init(payload, version, level)
    ccall((:qrpayload_init, libqrean), Cvoid, (Ptr{qrpayload_t}, qr_version_t, qr_errorlevel_t), payload, version, level)
end

function qrpayload_deinit(payload)
    ccall((:qrpayload_deinit, libqrean), Cvoid, (Ptr{qrpayload_t},), payload)
end

function create_qrpayload(version, level)
    ccall((:create_qrpayload, libqrean), qrpayload_t, (qr_version_t, qr_errorlevel_t), version, level)
end

function create_qrpayload_for_string(version, level, src)
    ccall((:create_qrpayload_for_string, libqrean), qrpayload_t, (qr_version_t, qr_errorlevel_t, Ptr{Cchar}), version, level, src)
end

function qrpayload_destroy(payload)
    ccall((:qrpayload_destroy, libqrean), Cvoid, (Ptr{qrpayload_t},), payload)
end

function new_qrpayload(version, level)
    ccall((:new_qrpayload, libqrean), Ptr{qrpayload_t}, (qr_version_t, qr_errorlevel_t), version, level)
end

function new_qrpayload_for_string(version, level, src)
    ccall((:new_qrpayload_for_string, libqrean), Ptr{qrpayload_t}, (qr_version_t, qr_errorlevel_t, Ptr{Cchar}), version, level, src)
end

function qrpayload_free(payload)
    ccall((:qrpayload_free, libqrean), Cvoid, (Ptr{qrpayload_t},), payload)
end

function qrpayload_get_bitstream(payload)
    ccall((:qrpayload_get_bitstream, libqrean), bitstream_t, (Ptr{qrpayload_t},), payload)
end

function qrpayload_get_bitstream_for_data(payload)
    ccall((:qrpayload_get_bitstream_for_data, libqrean), bitstream_t, (Ptr{qrpayload_t},), payload)
end

function qrpayload_get_bitstream_for_error(payload)
    ccall((:qrpayload_get_bitstream_for_error, libqrean), bitstream_t, (Ptr{qrpayload_t},), payload)
end

function qrpayload_set_error_words(payload)
    ccall((:qrpayload_set_error_words, libqrean), Cvoid, (Ptr{qrpayload_t},), payload)
end

function qrpayload_fix_errors(payload)
    ccall((:qrpayload_fix_errors, libqrean), Cint, (Ptr{qrpayload_t},), payload)
end

function qrpayload_read_string(payload, buffer, size)
    ccall((:qrpayload_read_string, libqrean), Csize_t, (Ptr{qrpayload_t}, Ptr{Cchar}, Csize_t), payload, buffer, size)
end

function qrpayload_write_string(payload, src, len, writer)
    ccall((:qrpayload_write_string, libqrean), bit_t, (Ptr{qrpayload_t}, Ptr{Cchar}, Csize_t, qrdata_writer_t), payload, src, len, writer)
end

function qrpayload_dump(payload, out)
    ccall((:qrpayload_dump, libqrean), Cvoid, (Ptr{qrpayload_t}, Ptr{Libc.FILE}), payload, out)
end

function qrpayload_dump_data(payload, out)
    ccall((:qrpayload_dump_data, libqrean), Cvoid, (Ptr{qrpayload_t}, Ptr{Libc.FILE}), payload, out)
end

function qrpayload_dump_error(payload, out)
    ccall((:qrpayload_dump_error, libqrean), Cvoid, (Ptr{qrpayload_t}, Ptr{Libc.FILE}), payload, out)
end

struct qrversion_t
    version::qr_version_t
    value::UInt32
end

function qrversion_for(version)
    ccall((:qrversion_for, libqrean), qrversion_t, (qr_version_t,), version)
end

function qrversion_from(version)
    ccall((:qrversion_from, libqrean), qrversion_t, (UInt32,), version)
end

struct padding_t
    data::NTuple{4, UInt8}
end

function Base.getproperty(x::Ptr{padding_t}, f::Symbol)
    f === :t && return Ptr{UInt8}(x + 0)
    f === :r && return Ptr{UInt8}(x + 1)
    f === :b && return Ptr{UInt8}(x + 2)
    f === :l && return Ptr{UInt8}(x + 3)
    f === :padding && return Ptr{NTuple{4, UInt8}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::padding_t, f::Symbol)
    r = Ref{padding_t}(x)
    ptr = Base.unsafe_convert(Ptr{padding_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{padding_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

function create_padding1(p)
    ccall((:create_padding1, libqrean), padding_t, (UInt8,), p)
end

function create_padding2(y, x)
    ccall((:create_padding2, libqrean), padding_t, (UInt8, UInt8), y, x)
end

function create_padding3(t, x, b)
    ccall((:create_padding3, libqrean), padding_t, (UInt8, UInt8, UInt8), t, x, b)
end

function create_padding4(t, r, b, l)
    ccall((:create_padding4, libqrean), padding_t, (UInt8, UInt8, UInt8, UInt8), t, r, b, l)
end

function hamming_distance(a, b)
    ccall((:hamming_distance, libqrean), uint_fast8_t, (UInt32, UInt32), a, b)
end

function hamming_distance_mem(mem1, mem2, bitlen)
    ccall((:hamming_distance_mem, libqrean), uint_fast8_t, (Ptr{UInt8}, Ptr{UInt8}, bitpos_t), mem1, mem2, bitlen)
end

function calc_pattern_mismatch_error_rate(bs, pattern, size, start_idx, n)
    ccall((:calc_pattern_mismatch_error_rate, libqrean), Cint, (Ptr{bitstream_t}, Ptr{Cvoid}, bitpos_t, bitpos_t, bitpos_t), bs, pattern, size, start_idx, n)
end

struct _qrean_canvas_t
    symbol_width::UInt8
    symbol_height::UInt8
    stride::UInt8
    bitmap_width::UInt8
    bitmap_height::UInt8
    bitmap_scale::UInt8
    bitmap_padding::padding_t
    buffer::NTuple{3917, UInt8}
    write_pixel::Ptr{Cvoid}
    opaque_write::Ptr{Cvoid}
    read_pixel::Ptr{Cvoid}
    opaque_read::Ptr{Cvoid}
end

const qrean_canvas_t = _qrean_canvas_t

@cenum qrean_code_type_t::UInt32 begin
    QREAN_CODE_TYPE_INVALID = 0
    QREAN_CODE_TYPE_QR = 1
    QREAN_CODE_TYPE_MQR = 2
    QREAN_CODE_TYPE_RMQR = 3
    QREAN_CODE_TYPE_TQR = 4
    QREAN_CODE_TYPE_EAN13 = 5
    QREAN_CODE_TYPE_EAN8 = 6
    QREAN_CODE_TYPE_UPCA = 7
    QREAN_CODE_TYPE_CODE39 = 8
    QREAN_CODE_TYPE_CODE93 = 9
    QREAN_CODE_TYPE_NW7 = 10
    QREAN_CODE_TYPE_ITF = 11
end

struct qrean_code_t
    data::NTuple{248, UInt8}
end

function Base.getproperty(x::Ptr{qrean_code_t}, f::Symbol)
    f === :type && return Ptr{qrean_code_type_t}(x + 0)
    f === :init && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :deinit && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :write_data && return Ptr{Ptr{Cvoid}}(x + 24)
    f === :read_data && return Ptr{Ptr{Cvoid}}(x + 32)
    f === :score && return Ptr{Ptr{Cvoid}}(x + 40)
    f === :data_iter && return Ptr{bitstream_iterator_t}(x + 48)
    f === :qr && return Ptr{Cvoid}(x + 56)
    return getfield(x, f)
end

function Base.getproperty(x::qrean_code_t, f::Symbol)
    r = Ref{qrean_code_t}(x)
    ptr = Base.unsafe_convert(Ptr{qrean_code_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{qrean_code_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct _qrean_t
    data::NTuple{3984, UInt8}
end

function Base.getproperty(x::Ptr{_qrean_t}, f::Symbol)
    f === :code && return Ptr{Ptr{qrean_code_t}}(x + 0)
    f === :canvas && return Ptr{qrean_canvas_t}(x + 8)
    f === :qr && return Ptr{Cvoid}(x + 3968)
    return getfield(x, f)
end

function Base.getproperty(x::_qrean_t, f::Symbol)
    r = Ref{_qrean_t}(x)
    ptr = Base.unsafe_convert(Ptr{_qrean_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{_qrean_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const qrean_t = _qrean_t

@cenum qrean_data_type_t::UInt32 begin
    QREAN_DATA_TYPE_AUTO = 0
    QREAN_DATA_TYPE_NUMERIC = 1
    QREAN_DATA_TYPE_ALNUM = 2
    QREAN_DATA_TYPE_8BIT = 3
    QREAN_DATA_TYPE_KANJI = 4
end

struct qrean_bitpattern_t
    iter::bitstream_iterator_t
    bits::Ptr{UInt8}
    size::bitpos_t
end

function qrean_init(qrean, type)
    ccall((:qrean_init, libqrean), bit_t, (Ptr{qrean_t}, qrean_code_type_t), qrean, type)
end

function create_qrean(type)
    ccall((:create_qrean, libqrean), qrean_t, (qrean_code_type_t,), type)
end

function qrean_destroy(qrean)
    ccall((:qrean_destroy, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function new_qrean(type)
    ccall((:new_qrean, libqrean), Ptr{qrean_t}, (qrean_code_type_t,), type)
end

function qrean_free(qrean)
    ccall((:qrean_free, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_set_symbol_size(qrean, width, height)
    ccall((:qrean_set_symbol_size, libqrean), bit_t, (Ptr{qrean_t}, UInt8, UInt8), qrean, width, height)
end

function qrean_set_symbol_width(qrean, width)
    ccall((:qrean_set_symbol_width, libqrean), bit_t, (Ptr{qrean_t}, UInt8), qrean, width)
end

function qrean_set_symbol_height(qrean, width)
    ccall((:qrean_set_symbol_height, libqrean), bit_t, (Ptr{qrean_t}, UInt8), qrean, width)
end

function qrean_set_qr_version(qrean, version)
    ccall((:qrean_set_qr_version, libqrean), bit_t, (Ptr{qrean_t}, qr_version_t), qrean, version)
end

function qrean_set_qr_errorlevel(qrean, level)
    ccall((:qrean_set_qr_errorlevel, libqrean), bit_t, (Ptr{qrean_t}, qr_errorlevel_t), qrean, level)
end

function qrean_set_qr_maskpattern(qrean, mask)
    ccall((:qrean_set_qr_maskpattern, libqrean), bit_t, (Ptr{qrean_t}, qr_maskpattern_t), qrean, mask)
end

function qrean_set_qr_format_info(qrean, fi)
    ccall((:qrean_set_qr_format_info, libqrean), bit_t, (Ptr{qrean_t}, qrformat_t), qrean, fi)
end

function qrean_set_qr_version_info(qrean, vi)
    ccall((:qrean_set_qr_version_info, libqrean), bit_t, (Ptr{qrean_t}, qrversion_t), qrean, vi)
end

function qrean_set_barcode_height(height)
    ccall((:qrean_set_barcode_height, libqrean), bit_t, (UInt8,), height)
end

function qrean_get_barcode_height(height)
    ccall((:qrean_get_barcode_height, libqrean), bit_t, (UInt8,), height)
end

function qrean_fix_errors(qrean)
    ccall((:qrean_fix_errors, libqrean), Cint, (Ptr{qrean_t},), qrean)
end

function qrean_check_errors(qrean)
    ccall((:qrean_check_errors, libqrean), Cint, (Ptr{qrean_t},), qrean)
end

function qrean_read_qr_format_info(qrean, idx)
    ccall((:qrean_read_qr_format_info, libqrean), qrformat_t, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_version_info(qrean, idx)
    ccall((:qrean_read_qr_version_info, libqrean), qrversion_t, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_finder_pattern(qrean, idx)
    ccall((:qrean_read_qr_finder_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_finder_sub_pattern(qrean, idx)
    ccall((:qrean_read_qr_finder_sub_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_corner_finder_pattern(qrean, idx)
    ccall((:qrean_read_qr_corner_finder_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_border_pattern(qrean, idx)
    ccall((:qrean_read_qr_border_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_timing_pattern(qrean, idx)
    ccall((:qrean_read_qr_timing_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_alignment_pattern(qrean, idx)
    ccall((:qrean_read_qr_alignment_pattern, libqrean), Cint, (Ptr{qrean_t}, Cint), qrean, idx)
end

function qrean_read_qr_version(qrean)
    ccall((:qrean_read_qr_version, libqrean), qr_version_t, (Ptr{qrean_t},), qrean)
end

function qrean_read_qr_maskpattern(qrean)
    ccall((:qrean_read_qr_maskpattern, libqrean), qr_maskpattern_t, (Ptr{qrean_t},), qrean)
end

function qrean_read_qr_errorlevel(qrean)
    ccall((:qrean_read_qr_errorlevel, libqrean), qr_errorlevel_t, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_format_info(qrean)
    ccall((:qrean_write_qr_format_info, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_version_info(qrean)
    ccall((:qrean_write_qr_version_info, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_finder_pattern(qrean)
    ccall((:qrean_write_qr_finder_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_finder_sub_pattern(qrean)
    ccall((:qrean_write_qr_finder_sub_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_corner_finder_pattern(qrean)
    ccall((:qrean_write_qr_corner_finder_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_border_pattern(qrean)
    ccall((:qrean_write_qr_border_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_timing_pattern(qrean)
    ccall((:qrean_write_qr_timing_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_alignment_pattern(qrean)
    ccall((:qrean_write_qr_alignment_pattern, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_qr_data(qrean, buffer, len, data_type)
    ccall((:qrean_write_qr_data, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cvoid}, Csize_t, qrean_data_type_t), qrean, buffer, len, data_type)
end

function qrean_read_qr_data(qrean, buffer, size)
    ccall((:qrean_read_qr_data, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cvoid}, Csize_t), qrean, buffer, size)
end

function qrean_write_qr_payload(qrean, payload)
    ccall((:qrean_write_qr_payload, libqrean), bitpos_t, (Ptr{qrean_t}, Ptr{qrpayload_t}), qrean, payload)
end

function qrean_read_qr_payload(qrean, payload)
    ccall((:qrean_read_qr_payload, libqrean), bitpos_t, (Ptr{qrean_t}, Ptr{qrpayload_t}), qrean, payload)
end

function qrean_write_frame(qrean)
    ccall((:qrean_write_frame, libqrean), Cvoid, (Ptr{qrean_t},), qrean)
end

function qrean_write_string(qrean, str, data_type)
    ccall((:qrean_write_string, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cchar}, qrean_data_type_t), qrean, str, data_type)
end

function qrean_write_buffer(qrean, buffer, len, data_type)
    ccall((:qrean_write_buffer, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cchar}, Csize_t, qrean_data_type_t), qrean, buffer, len, data_type)
end

function qrean_read_string(qrean, buffer, size)
    ccall((:qrean_read_string, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cchar}, Csize_t), qrean, buffer, size)
end

function qrean_read_buffer(qrean, buffer, size)
    ccall((:qrean_read_buffer, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cchar}, Csize_t), qrean, buffer, size)
end

function qrean_write_pixel(qrean, x, y, v)
    ccall((:qrean_write_pixel, libqrean), Cvoid, (Ptr{qrean_t}, Cint, Cint, bit_t), qrean, x, y, v)
end

function qrean_read_pixel(qrean, x, y)
    ccall((:qrean_read_pixel, libqrean), bit_t, (Ptr{qrean_t}, Cint, Cint), qrean, x, y)
end

function qrean_write_bitmap(qrean, buffer, size, bpp)
    ccall((:qrean_write_bitmap, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cvoid}, Csize_t, bitpos_t), qrean, buffer, size, bpp)
end

function qrean_read_bitmap(qrean, buffer, size, bpp)
    ccall((:qrean_read_bitmap, libqrean), Csize_t, (Ptr{qrean_t}, Ptr{Cvoid}, Csize_t, bitpos_t), qrean, buffer, size, bpp)
end

function qrean_read_bitstream(qrean, src)
    ccall((:qrean_read_bitstream, libqrean), bitpos_t, (Ptr{qrean_t}, bitstream_t), qrean, src)
end

function qrean_write_bitstream(qrean, src)
    ccall((:qrean_write_bitstream, libqrean), bitpos_t, (Ptr{qrean_t}, bitstream_t), qrean, src)
end

function qrean_set_bitmap_padding(qrean, padding)
    ccall((:qrean_set_bitmap_padding, libqrean), bit_t, (Ptr{qrean_t}, padding_t), qrean, padding)
end

function qrean_get_bitmap_padding(qrean)
    ccall((:qrean_get_bitmap_padding, libqrean), padding_t, (Ptr{qrean_t},), qrean)
end

function qrean_set_bitmap_scale(qrean, scale)
    ccall((:qrean_set_bitmap_scale, libqrean), bit_t, (Ptr{qrean_t}, UInt8), qrean, scale)
end

function qrean_get_bitmap_scale(qrean)
    ccall((:qrean_get_bitmap_scale, libqrean), UInt8, (Ptr{qrean_t},), qrean)
end

function qrean_get_bitmap_width(qrean)
    ccall((:qrean_get_bitmap_width, libqrean), Csize_t, (Ptr{qrean_t},), qrean)
end

function qrean_get_bitmap_height(qrean)
    ccall((:qrean_get_bitmap_height, libqrean), Csize_t, (Ptr{qrean_t},), qrean)
end

function qrean_dump(qrean, out)
    ccall((:qrean_dump, libqrean), Cvoid, (Ptr{qrean_t}, Ptr{Libc.FILE}), qrean, out)
end

function qrean_fill(qrean, v)
    ccall((:qrean_fill, libqrean), Cvoid, (Ptr{qrean_t}, bit_t), qrean, v)
end

function qrean_on_write_pixel(qrean, write_pixel, opaque)
    ccall((:qrean_on_write_pixel, libqrean), Cvoid, (Ptr{qrean_t}, Ptr{Cvoid}, Ptr{Cvoid}), qrean, write_pixel, opaque)
end

function qrean_on_read_pixel(qrean, read_pixel, opaque)
    ccall((:qrean_on_read_pixel, libqrean), Cvoid, (Ptr{qrean_t}, Ptr{Cvoid}, Ptr{Cvoid}), qrean, read_pixel, opaque)
end

function qrean_create_bitstream(qrean, iter)
    ccall((:qrean_create_bitstream, libqrean), bitstream_t, (Ptr{qrean_t}, bitstream_iterator_t), qrean, iter)
end

function qrean_check_qr_combination(qrean)
    ccall((:qrean_check_qr_combination, libqrean), Cint, (Ptr{qrean_t},), qrean)
end

function qrean_error(message)
    ccall((:qrean_error, libqrean), Cvoid, (Ptr{Cchar},), message)
end

function qrean_on_debug_vprintf(vprintf_like, opaque)
    ccall((:qrean_on_debug_vprintf, libqrean), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}), vprintf_like, opaque)
end

function qrean_on_error(func)
    ccall((:qrean_on_error, libqrean), Cvoid, (Ptr{Cvoid},), func)
end

# no prototype is found for this function at debug.h:14:13, please use with caution
function qrean_get_last_error()
    ccall((:qrean_get_last_error, libqrean), Ptr{Cchar}, ())
end

struct image_point_t
    x::Cfloat
    y::Cfloat
end

function create_image_point(x, y)
    ccall((:create_image_point, libqrean), image_point_t, (Cfloat, Cfloat), x, y)
end

const image_pixel_t = UInt32

struct image_t
    buffer::Ptr{image_pixel_t}
    width::Csize_t
    height::Csize_t
end

struct image_extent_t
    top::Cfloat
    right::Cfloat
    bottom::Cfloat
    left::Cfloat
end

struct image_paint_result_t
    extent::image_extent_t
    area::Cint
end

struct image_transform_matrix_t
    m::NTuple{8, Cfloat}
end

function new_image(width, height)
    ccall((:new_image, libqrean), Ptr{image_t}, (Csize_t, Csize_t), width, height)
end

function image_free(img)
    ccall((:image_free, libqrean), Cvoid, (Ptr{image_t},), img)
end

function image_clone(img)
    ccall((:image_clone, libqrean), Ptr{image_t}, (Ptr{image_t},), img)
end

function new_image_from_qrean(qrean)
    ccall((:new_image_from_qrean, libqrean), Ptr{image_t}, (Ptr{qrean_t},), qrean)
end

function image_point_add(a, b)
    ccall((:image_point_add, libqrean), image_point_t, (image_point_t, image_point_t), a, b)
end

function image_point_sub(a, b)
    ccall((:image_point_sub, libqrean), image_point_t, (image_point_t, image_point_t), a, b)
end

function image_draw_pixel(img, p, pixel)
    ccall((:image_draw_pixel, libqrean), Cvoid, (Ptr{image_t}, image_point_t, image_pixel_t), img, p, pixel)
end

function image_read_pixel(img, p)
    ccall((:image_read_pixel, libqrean), image_pixel_t, (Ptr{image_t}, image_point_t), img, p)
end

function image_dump(img, out)
    ccall((:image_dump, libqrean), Cvoid, (Ptr{image_t}, Ptr{Libc.FILE}), img, out)
end

function image_save_as_ppm(img, out)
    ccall((:image_save_as_ppm, libqrean), Cvoid, (Ptr{image_t}, Ptr{Libc.FILE}), img, out)
end

function image_draw_line(img, s, e, pix, thickness)
    ccall((:image_draw_line, libqrean), Cvoid, (Ptr{image_t}, image_point_t, image_point_t, image_pixel_t, Cint), img, s, e, pix, thickness)
end

function image_draw_filled_rectangle(img, s, w, h, pix)
    ccall((:image_draw_filled_rectangle, libqrean), Cvoid, (Ptr{image_t}, image_point_t, Cint, Cint, image_pixel_t), img, s, w, h, pix)
end

function image_draw_filled_ellipse(img, center, w, h, pix)
    ccall((:image_draw_filled_ellipse, libqrean), Cvoid, (Ptr{image_t}, image_point_t, Cint, Cint, image_pixel_t), img, center, w, h, pix)
end

function image_draw_polygon(img, N, points, pixel, thickness)
    ccall((:image_draw_polygon, libqrean), Cvoid, (Ptr{image_t}, Cint, Ptr{image_point_t}, image_pixel_t, Cint), img, N, points, pixel, thickness)
end

# no prototype is found for this function at image.h:71:16, please use with caution
function create_image_extent()
    ccall((:create_image_extent, libqrean), image_extent_t, ())
end

function image_extent_update(extent, src)
    ccall((:image_extent_update, libqrean), Ptr{image_extent_t}, (Ptr{image_extent_t}, image_extent_t), extent, src)
end

function image_extent_center(extent)
    ccall((:image_extent_center, libqrean), image_point_t, (Ptr{image_extent_t},), extent)
end

function image_extent_dump(extent)
    ccall((:image_extent_dump, libqrean), Cvoid, (Ptr{image_extent_t},), extent)
end

function image_paint(img, p, pix)
    ccall((:image_paint, libqrean), image_paint_result_t, (Ptr{image_t}, image_point_t, image_pixel_t), img, p, pix)
end

function image_point_norm(a)
    ccall((:image_point_norm, libqrean), Cfloat, (image_point_t,), a)
end

function image_point_distance(a, b)
    ccall((:image_point_distance, libqrean), Cfloat, (image_point_t, image_point_t), a, b)
end

function image_point_angle(base, p)
    ccall((:image_point_angle, libqrean), Cfloat, (image_point_t, image_point_t), base, p)
end

function image_draw_extent(img, extent, pix, thickness)
    ccall((:image_draw_extent, libqrean), Cvoid, (Ptr{image_t}, image_extent_t, image_pixel_t, Cint), img, extent, pix, thickness)
end

function image_point_transform(p, matrix)
    ccall((:image_point_transform, libqrean), image_point_t, (image_point_t, image_transform_matrix_t), p, matrix)
end

function create_image_transform_matrix(src, dst)
    ccall((:create_image_transform_matrix, libqrean), image_transform_matrix_t, (Ptr{image_point_t}, Ptr{image_point_t}), src, dst)
end

function image_digitize(dst, src, gamma_value)
    ccall((:image_digitize, libqrean), Cvoid, (Ptr{image_t}, Ptr{image_t}, Cfloat), dst, src, gamma_value)
end

function image_monochrome(dst, src, gamma_value, hist_result)
    ccall((:image_monochrome, libqrean), Cvoid, (Ptr{image_t}, Ptr{image_t}, Cfloat, Ptr{Cint}), dst, src, gamma_value, hist_result)
end

function image_morphology_erode(img)
    ccall((:image_morphology_erode, libqrean), Cvoid, (Ptr{image_t},), img)
end

function image_morphology_dilate(img)
    ccall((:image_morphology_dilate, libqrean), Cvoid, (Ptr{image_t},), img)
end

function image_morphology_close(img)
    ccall((:image_morphology_close, libqrean), Cvoid, (Ptr{image_t},), img)
end

function image_morphology_open(img)
    ccall((:image_morphology_open, libqrean), Cvoid, (Ptr{image_t},), img)
end

struct qrean_detector_qr_finder_candidate_t
    center::image_point_t
    extent::image_extent_t
    corners::NTuple{4, image_point_t}
    area::Cint
end

struct qrean_detector_barcode_candidate_t
    code::uint_fast16_t
    s::image_point_t
    barsize::Cfloat
end

struct qrean_detector_perspective_t
    qrean::Ptr{qrean_t}
    img::Ptr{image_t}
    src::NTuple{4, image_point_t}
    dst::NTuple{4, image_point_t}
    h::image_transform_matrix_t
end

function qrean_detector_scan_barcodes(src, on_found, opaque)
    ccall((:qrean_detector_scan_barcodes, libqrean), Cint, (Ptr{image_t}, Ptr{Cvoid}, Ptr{Cvoid}), src, on_found, opaque)
end

function qrean_detector_scan_qr_finder_pattern(src, num_founds)
    ccall((:qrean_detector_scan_qr_finder_pattern, libqrean), Ptr{qrean_detector_qr_finder_candidate_t}, (Ptr{image_t}, Ptr{Cint}), src, num_founds)
end

function create_qrean_detector_perspective(qrean, img)
    ccall((:create_qrean_detector_perspective, libqrean), qrean_detector_perspective_t, (Ptr{qrean_t}, Ptr{image_t}), qrean, img)
end

function qrean_detector_perspective_read_image_pixel(qrean, x, y, pos, opaque)
    ccall((:qrean_detector_perspective_read_image_pixel, libqrean), bit_t, (Ptr{qrean_t}, bitpos_t, bitpos_t, bitpos_t, Ptr{Cvoid}), qrean, x, y, pos, opaque)
end

function qrean_detector_perspective_setup_by_qr_finder_pattern_centers(warp, src, border_offset)
    ccall((:qrean_detector_perspective_setup_by_qr_finder_pattern_centers, libqrean), Cvoid, (Ptr{qrean_detector_perspective_t}, Ptr{image_point_t}, Cint), warp, src, border_offset)
end

function qrean_detector_perspective_setup_by_qr_finder_pattern_ring_corners(warp, ring, offset)
    ccall((:qrean_detector_perspective_setup_by_qr_finder_pattern_ring_corners, libqrean), Cvoid, (Ptr{qrean_detector_perspective_t}, Ptr{image_point_t}, Cint), warp, ring, offset)
end

function qrean_detector_perspective_fit_for_qr(warp)
    ccall((:qrean_detector_perspective_fit_for_qr, libqrean), Cint, (Ptr{qrean_detector_perspective_t},), warp)
end

function qrean_detector_perspective_fit_for_rmqr(warp)
    ccall((:qrean_detector_perspective_fit_for_rmqr, libqrean), Cint, (Ptr{qrean_detector_perspective_t},), warp)
end

function qrean_detector_try_decode_qr(src, candidates, num_candidates, on_found, opaque)
    ccall((:qrean_detector_try_decode_qr, libqrean), Cint, (Ptr{image_t}, Ptr{qrean_detector_qr_finder_candidate_t}, Cint, Ptr{Cvoid}, Ptr{Cvoid}), src, candidates, num_candidates, on_found, opaque)
end

function qrean_detector_try_decode_mqr(src, candidates, num_candidates, on_found, opaque)
    ccall((:qrean_detector_try_decode_mqr, libqrean), Cint, (Ptr{image_t}, Ptr{qrean_detector_qr_finder_candidate_t}, Cint, Ptr{Cvoid}, Ptr{Cvoid}), src, candidates, num_candidates, on_found, opaque)
end

function qrean_detector_try_decode_rmqr(src, candidates, num_candidates, on_found, opaque)
    ccall((:qrean_detector_try_decode_rmqr, libqrean), Cint, (Ptr{image_t}, Ptr{qrean_detector_qr_finder_candidate_t}, Cint, Ptr{Cvoid}, Ptr{Cvoid}), src, candidates, num_candidates, on_found, opaque)
end

function qrean_detector_try_decode_tqr(src, candidates, num_candidates, on_found, opaque)
    ccall((:qrean_detector_try_decode_tqr, libqrean), Cint, (Ptr{image_t}, Ptr{qrean_detector_qr_finder_candidate_t}, Cint, Ptr{Cvoid}, Ptr{Cvoid}), src, candidates, num_candidates, on_found, opaque)
end

const gf2_value_t = UInt8

const gf2_poly_t = gf2_value_t

function gf2_add(a, b)
    ccall((:gf2_add, libqrean), gf2_value_t, (gf2_value_t, gf2_value_t), a, b)
end

function gf2_mul(a, b)
    ccall((:gf2_mul, libqrean), gf2_value_t, (gf2_value_t, gf2_value_t), a, b)
end

function gf2_pow(a, exp)
    ccall((:gf2_pow, libqrean), gf2_value_t, (gf2_value_t, Cint), a, exp)
end

function gf2_div(a, b)
    ccall((:gf2_div, libqrean), gf2_value_t, (gf2_value_t, gf2_value_t), a, b)
end

function gf2_pow_a(exp)
    ccall((:gf2_pow_a, libqrean), gf2_value_t, (Cint,), exp)
end

function gf2_log_a(val)
    ccall((:gf2_log_a, libqrean), gf2_value_t, (gf2_value_t,), val)
end

function gf2_poly_mul(ans, a, b)
    ccall((:gf2_poly_mul, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, a, b)
end

function gf2_poly_div(ans, a, b)
    ccall((:gf2_poly_div, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, a, b)
end

function gf2_poly_divmod(q, r, a, b)
    ccall((:gf2_poly_divmod, libqrean), Cvoid, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), q, r, a, b)
end

function gf2_poly_mod(ans, a, b)
    ccall((:gf2_poly_mod, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, a, b)
end

function gf2_poly_add(ans, a, b)
    ccall((:gf2_poly_add, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, a, b)
end

function gf2_poly_dif(ans, a)
    ccall((:gf2_poly_dif, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, a)
end

function gf2_poly_calc(a, value)
    ccall((:gf2_poly_calc, libqrean), gf2_value_t, (Ptr{gf2_poly_t}, gf2_value_t), a, value)
end

function gf2_poly_copy(dst, src)
    ccall((:gf2_poly_copy, libqrean), Cvoid, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), dst, src)
end

function gf2_poly_get_real_degree(a)
    ccall((:gf2_poly_get_real_degree, libqrean), Cint, (Ptr{gf2_poly_t},), a)
end

function gf2_poly_is_zero(poly)
    ccall((:gf2_poly_is_zero, libqrean), Cint, (Ptr{gf2_poly_t},), poly)
end

function gf2_solve_key_equation(sigma, omega, a, b)
    ccall((:gf2_solve_key_equation, libqrean), Cvoid, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), sigma, omega, a, b)
end

function gf2_poly_dump(poly, out)
    ccall((:gf2_poly_dump, libqrean), Cvoid, (Ptr{gf2_poly_t}, Ptr{Libc.FILE}), poly, out)
end

function qrbch_15_5_value(index)
    ccall((:qrbch_15_5_value, libqrean), UInt32, (uint_fast8_t,), index)
end

function qrbch_18_6_value(index)
    ccall((:qrbch_18_6_value, libqrean), UInt32, (uint_fast8_t,), index)
end

function qrbch_15_5_index_of(value)
    ccall((:qrbch_15_5_index_of, libqrean), Cint, (UInt32,), value)
end

function qrbch_18_6_index_of(value)
    ccall((:qrbch_18_6_index_of, libqrean), Cint, (UInt32,), value)
end

function qrspec_get_symbol_width(version)
    ccall((:qrspec_get_symbol_width, libqrean), uint_fast8_t, (qr_version_t,), version)
end

function qrspec_get_symbol_height(version)
    ccall((:qrspec_get_symbol_height, libqrean), uint_fast8_t, (qr_version_t,), version)
end

function qrspec_get_alignment_num(version)
    ccall((:qrspec_get_alignment_num, libqrean), uint_fast8_t, (qr_version_t,), version)
end

function qrspec_get_alignment_steps(version, step)
    ccall((:qrspec_get_alignment_steps, libqrean), uint_fast8_t, (qr_version_t, uint_fast8_t), version, step)
end

function qrspec_get_alignment_position_x(version, idx)
    ccall((:qrspec_get_alignment_position_x, libqrean), uint_fast8_t, (qr_version_t, uint_fast8_t), version, idx)
end

function qrspec_get_alignment_position_y(version, idx)
    ccall((:qrspec_get_alignment_position_y, libqrean), uint_fast8_t, (qr_version_t, uint_fast8_t), version, idx)
end

function qrspec_get_available_bits(version)
    ccall((:qrspec_get_available_bits, libqrean), Csize_t, (qr_version_t,), version)
end

function qrspec_get_total_blocks(version, level)
    ccall((:qrspec_get_total_blocks, libqrean), uint_fast8_t, (qr_version_t, qr_errorlevel_t), version, level)
end

function qrspec_get_error_words_in_block(version, level)
    ccall((:qrspec_get_error_words_in_block, libqrean), uint_fast8_t, (qr_version_t, qr_errorlevel_t), version, level)
end

function qrspec_get_data_bitlength_for(version, mode)
    ccall((:qrspec_get_data_bitlength_for, libqrean), uint_fast8_t, (qr_version_t, Cint), version, mode)
end

function qrspec_get_version_string(version)
    ccall((:qrspec_get_version_string, libqrean), Ptr{Cchar}, (qr_version_t,), version)
end

function qrspec_get_version_by_string(version)
    ccall((:qrspec_get_version_by_string, libqrean), qr_version_t, (Ptr{Cchar},), version)
end

function qrspec_is_valid_combination(version, level, mask)
    ccall((:qrspec_is_valid_combination, libqrean), Cint, (qr_version_t, qr_errorlevel_t, qr_maskpattern_t), version, level, mask)
end

function rs_init_generator_polynomial(ans)
    ccall((:rs_init_generator_polynomial, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t},), ans)
end

function rs_calc_parity(ans, I, g)
    ccall((:rs_calc_parity, libqrean), Ptr{gf2_poly_t}, (Ptr{gf2_poly_t}, Ptr{gf2_poly_t}, Ptr{gf2_poly_t}), ans, I, g)
end

function rs_fix_errors(r, error_words)
    ccall((:rs_fix_errors, libqrean), Cint, (Ptr{gf2_poly_t}, Cint), r, error_words)
end

const runlength_count_t = Cuint

const runlength_size_t = Cuint

struct runlength_t
    ringbuf::NTuple{16, runlength_count_t}
    idx::Csize_t
    last_value::UInt32
end

# no prototype is found for this function at runlength.h:22:13, please use with caution
function create_runlength()
    ccall((:create_runlength, libqrean), runlength_t, ())
end

function runlength_init(rl)
    ccall((:runlength_init, libqrean), Cvoid, (Ptr{runlength_t},), rl)
end

function runlength_get_count(rl, back)
    ccall((:runlength_get_count, libqrean), runlength_count_t, (Ptr{runlength_t}, runlength_size_t), rl, back)
end

function runlength_latest_count(rl)
    ccall((:runlength_latest_count, libqrean), runlength_count_t, (Ptr{runlength_t},), rl)
end

function runlength_sum(rl, s, e)
    ccall((:runlength_sum, libqrean), runlength_count_t, (Ptr{runlength_t}, runlength_size_t, runlength_size_t), rl, s, e)
end

function runlength_next(rl)
    ccall((:runlength_next, libqrean), Cvoid, (Ptr{runlength_t},), rl)
end

function runlength_push_value(rl, value)
    ccall((:runlength_push_value, libqrean), Cint, (Ptr{runlength_t}, UInt32), rl, value)
end

function runlength_count(rl)
    ccall((:runlength_count, libqrean), Cvoid, (Ptr{runlength_t},), rl)
end

function runlength_count_add(rl, n)
    ccall((:runlength_count_add, libqrean), Cvoid, (Ptr{runlength_t}, runlength_count_t), rl, n)
end

function runlength_next_and_count(rl)
    ccall((:runlength_next_and_count, libqrean), Cvoid, (Ptr{runlength_t},), rl)
end

function runlength_next_and_count_add(rl, n)
    ccall((:runlength_next_and_count_add, libqrean), Cvoid, (Ptr{runlength_t}, runlength_count_t), rl, n)
end

function runlength_dump(rl, out)
    ccall((:runlength_dump, libqrean), Cvoid, (Ptr{runlength_t}, Ptr{Libc.FILE}), rl, out)
end

const BITPOS_TRUNC = 0xffffffff

const BITPOS_BLANK = 0xfffffffe

const BITPOS_END = 0xfffffffd

const BITPOS_MASK = 0x7fffffff

const BITPOS_TOGGLE = 0x80000000

const RSBLOCK_BUFFER_SIZE = 3706

const QR_VERSIONINFO_SIZE = 18

const QREAN_CANVAS_MAX_BUFFER_SIZE = 3917

const QREAN_BANNER = "[libqrean] "

#const POINT_INVALID = create_image_point(NAN, NAN)

const MAX_CANDIDATES = 30

const GF2_MAX_EXP = 255

const MAX_RUNLENGTH = 16

end # module

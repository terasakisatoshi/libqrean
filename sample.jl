include("LibQREAN.jl")

using .LibQREAN

qrean = LibQREAN.create_qrean(LibQREAN.QREAN_CODE_TYPE_RMQR) |> Ref
scale = Cint(4)
padding = LibQREAN.create_padding1(Cint(4))

LibQREAN.qrean_set_bitmap_scale(qrean, scale);
LibQREAN.qrean_set_bitmap_padding(qrean, padding);

data = "Hello"
len = Csize_t(length(data))

wrote = LibQREAN.qrean_write_buffer(qrean, data, len, LibQREAN.QREAN_DATA_TYPE_AUTO);

out = Libc.FILE(Libc.RawFD(1), "w")
LibQREAN.qrean_dump(qrean, out)
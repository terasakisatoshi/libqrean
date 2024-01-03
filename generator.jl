using Clang
using Clang.Generators

cd(@__DIR__)

include_dir = "./src"
c_code_dir = include_dir

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")

push!(args, "-D DEBUG_QRDATA")
push!(args, "-lm")
push!(args, "-lsrc/libqrean")

headers = [joinpath(c_code_dir, header) for header in readdir(c_code_dir) if endswith(header, ".h")]

# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(c_code_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
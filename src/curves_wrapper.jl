const libcurves =
    Sys.iswindows() ? "curves.dll" :
    Sys.isapple()   ? "libcurves.dylib" :
                      "libcurves.so"

function hilbert_index(x::Integer, y::Integer, bits::Integer)::Int32
    ccall((:hilbert_index, libcurves), UInt32,
          (UInt32, UInt32, Cint),
          UInt32(x), UInt32(y), Cint(bits)) |> Int32
end

function z_index(x::Integer, y::Integer)::Int32
    ccall((:z_index, libcurves), UInt32,
          (UInt32, UInt32),
          UInt32(x), UInt32(y)) |> Int32
end

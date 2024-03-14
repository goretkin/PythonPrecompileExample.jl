# Introduction
Example of precompiling for `PythonCall.jl`

# Getting list of method instances that should be precompiled
```
~/repos/PythonCallPrecompileExample$ julia --project=.
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.10.2 (2024-03-01)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> 

julia> ENV["JULIA_CONDAPKG_BACKEND"] = "Null" # use the system installation of Python
"Null"

julia> using PythonCallPrecompileExample

julia> PythonCallPrecompileExample.get_precompilation()
/usr/bin/python
128-element Vector{Any}:
 MethodInstance for PythonCall.pyjlmodule_seval(::Module, ::PythonCall.Py)
 MethodInstance for UnsafePointers.var"#s5#15"(::Any, ::Any, ::Any, ::Type, ::Any)
 MethodInstance for UnsafePointers.var"#s5#13"(::Any, ::Any, ::Any, ::Type, ::Any)
 MethodInstance for findfirst(::Function, ::NTuple{49, Symbol})
 MethodInstance for Base._findfirst_loop(::Base.Fix2{typeof(==), Symbol}, ::NTuple{49, Symbol})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.PyTypeObject}, ::Val{:flags})
 MethodInstance for UnsafePointers.var"#s5#14"(::Any, ::Any, ::Any, ::Type, ::Any)
 MethodInstance for PythonCall.var"#s282#56"(::Any, ::Any, ::Any)
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{String})
 MethodInstance for Core.Compiler.eltype(::Type{Vector{Base.HasEltype}})
 MethodInstance for Core.Compiler.eltype(::Type{Vector{Base.HasShape{1}}})
 MethodInstance for fieldtypes(::Type)
 MethodInstance for Base.Iterators.map(::Function, ::Tuple{DataType, DataType})
 MethodInstance for (::Base.var"#48#49")(::Type{PythonCall.Py})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.PyTypeObject}, ::Val{:as_buffer})
 MethodInstance for findfirst(::Function, ::Tuple{Symbol, Symbol})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.PyBufferProcs}, ::Val{:get})
 MethodInstance for Base.unwrapva(::Type{PythonCall.Py})
 MethodInstance for Base.rewrap_unionall(::Type{PythonCall.Py}, ::Type{Tuple{PythonCall.Py, String}})
 MethodInstance for push!(::Base.IdSet{Any}, ::Type{PythonCall.Py})
 MethodInstance for Base.rewrap_unionall(::DataType, ::Type{Tuple{PythonCall.Py, String}})
 MethodInstance for Base.IteratorSize(::Type{Base.Generator{I, PythonCall.var"#43#48"}}) where I
 MethodInstance for iterate(::Base.Iterators.Filter{PythonCall.var"#44#50"})
 MethodInstance for (::PythonCall.var"#44#50")(::Any)
 MethodInstance for !=(::Any, ::Type{Union{}})
 MethodInstance for iterate(::Base.Iterators.Filter{PythonCall.var"#44#50"}, ::Any)
 MethodInstance for PythonCall.Py(::Nothing)
 MethodInstance for PythonCall.pyjlany_getattr(::Module, ::PythonCall.Py)
 MethodInstance for PythonCall.Py(::Function)
 MethodInstance for findfirst(::Function, ::Tuple{Symbol, Symbol, Symbol})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.PyJuliaValueObject}, ::Val{:value})
 MethodInstance for PythonCall.pyjlany_call(::typeof(PythonCallPrecompileExample.foo), ::PythonCall.Py, ::PythonCall.Py)
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{Vector{Any}})
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{Dict{Symbol, Any}})
 MethodInstance for PythonCallPrecompileExample.foo(::Any)
 ⋮
 MethodInstance for PythonCall.pyconvert_fix(::Type{Set}, ::typeof(PythonCall.pyconvert_rule_iterable))
 MethodInstance for PythonCall.pyconvert_fix(::Type{PythonCall.Py}, ::typeof(PythonCall.pyconvert_rule_object))
 MethodInstance for (::PythonCall.var"#54#55"{PythonCall.PyArray, typeof(PythonCall.pyconvert_rule_array_nocopy)})(::PythonCall.Py)
 MethodInstance for ==(::TypeVar, ::TypeVar)
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{Vector{Int64}})
 MethodInstance for Core.Compiler.eltype(::Type{Vector{DataType}})
 MethodInstance for PythonCall.pyarray_get_size(::PythonCall.PyArraySource_ArrayStruct, ::Val)
 MethodInstance for PythonCall.pyarray_get_strides(::PythonCall.PyArraySource_ArrayStruct, ::Val{N}, ::DataType, ::Tuple{Vararg{Int64, N}}) where N
 MethodInstance for ==(::Type{Bool}, ::Type{Int64})
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{Int64})
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{UInt64})
 MethodInstance for get!(::Type{Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Dict{Type, Dict{Ptr{PythonCall.C.PyObject}, Vector{Function}}}, ::Type{Bool})
 MethodInstance for findfirst(::Function, ::NTuple{7, Symbol})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.PyMemoryViewObject}, ::Val{:view})
 MethodInstance for PythonCall.pytryconvert(::Type{Tuple{Vararg{Int64, _A}}} where _A, ::PythonCall.Py)
 MethodInstance for PythonCall.pyconvert_rule_fast(::Type{Tuple{Vararg{Int64, _A}}} where _A, ::PythonCall.Py)
 MethodInstance for nameof(::Type{<:Int64})
 MethodInstance for findfirst(::Function, ::NTuple{11, Symbol})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:format})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:buf})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:ndim})
 MethodInstance for PythonCall.pyarray_get_size(::PythonCall.PyArraySource_Buffer, ::Val)
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:shape})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:len})
 MethodInstance for PythonCall.pyarray_get_strides(::PythonCall.PyArraySource_Buffer, ::Val{N}, ::DataType, ::Tuple{Vararg{Int64, N}}) where N
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:strides})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:itemsize})
 MethodInstance for UnsafePointers._fieldindex(::Type{PythonCall.C.Py_buffer}, ::Val{:readonly})
 MethodInstance for PythonCall.pyarray_get_size(::PythonCall.PyArraySource_ArrayStruct, ::Val{2})
 MethodInstance for PythonCall.pyarray_get_strides(::PythonCall.PyArraySource_ArrayStruct, ::Val{2}, ::Type{Float64}, ::Tuple{Int64, Int64})
 MethodInstance for PythonCall.Utils.size_to_fstrides(::Int64, ::Tuple{Int64, Int64})
 MethodInstance for PythonCall.PyArray{Float64, 2, true, false, Float64}(::Val{:new}, ::Ptr{Float64}, ::Tuple{Int64, Int64}, ::Tuple{Int64, Int64}, ::PythonCall.Py, ::PythonCall.Py)
 MethodInstance for PythonCallPrecompileExample.foo(::PythonCall.PyArray{Float64, 2, true, false, Float64})
 MethodInstance for PythonCall.Py(::Matrix{Float64})
```
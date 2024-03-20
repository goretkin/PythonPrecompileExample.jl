module PythonCallPrecompileExample

using PrecompileTools
using Serialization: serialize, deserialize

function foo(xs)
    [i*x for (i, x) in enumerate(xs)]
end

# ENV["JULIA_CONDAPKG_BACKEND"] = "Null" # use the system installation of Python
using PythonCall: pyexec, pyexec

py_precompile_script = """
import numpy as np
# Use this way to make an anonymous module to avoid:
#         Info Given PythonCallPrecompileExample was explicitly requested, output will be shown live
# ERROR: LoadError: Python: Julia: Creating a new global in closed module `Main` (`PythonCallPrecompileExample`) breaks incremental compilation because the side effects will not be permanent.

jl = juliacall.Base.Module()

jl.seval("using PythonCallPrecompileExample")

xs = np.random.rand(2, 2)
ans = jl.PythonCallPrecompileExample.foo(xs)
"""

function get_precompilation_list()
    pyexec("import sys; print(sys.executable)", Main)

    Core.Compiler.Timings.reset_timings()
    Core.Compiler.__set_measure_typeinf(true)

    pyexec(py_precompile_script, Main)

    Core.Compiler.__set_measure_typeinf(false)
    Core.Compiler.Timings.close_current_timer()

    precompile_method_instances = Any[]
    function precompile_mi(mi)
        push!(precompile_method_instances, mi)
    end


    # begin copy from PrecompileTools
    """
    check_edges(node)

    Recursively ensure that all callees of `node` are precompiled. This is (rarely) necessary
    because sometimes there is no backedge from callee to caller (xref https://github.com/JuliaLang/julia/issues/49617),
    and `staticdata.c` relies on the backedge to trace back to a MethodInstance that is tagged `mi.precompiled`.
    """
    function check_edges(node)
    parentmi = node.mi_info.mi
    for child in node.children
        childmi = child.mi_info.mi
        if !(isdefined(childmi, :backedges) && parentmi ∈ childmi.backedges)
            precompile_mi(childmi)
        end
        check_edges(child)
    end
    end

    function precompile_roots(roots)
    # @assert have_inference_tracking
    for child in roots
        precompile_mi(child.mi_info.mi)
        check_edges(child)
    end
    end

    precompile_roots(Core.Compiler.Timings._timings[1].children)
    # end copy

    return precompile_method_instances
end

function is_serializable(x)
    try
        open("/tmp/garbage.jls", "w") do file
            serialize(file, x)
        end
        return true
    catch e
        if e isa MethodError
            return false
        end
        rethrow(e)
    end
end

# PythonCallPrecompileExample.write_precompilation_list(filter(PythonCallPrecompileExample.is_serializable, pcl))
function write_precompilation_list(precompilation_list)
    open("/tmp/precompilation_list.jls", "w") do file
        serialize(file, precompilation_list)
    end
end



# Uncomment this to hook into the precompilation. But it's circular, and it is giving

module PlaceholderForPrecompilation
end

# This is the standard precompilation approach, but on Julia v1.10.2 and PythonCall v0.9.15 it causes
# ERROR: LoadError: Python: Julia: Evaluation into the closed module `anonymous` breaks incremental compilation because the side effects will not be permanent. This is likely due to some other module mutating `anonymous` with `eval` during precompilation - don't do this.
# module PlaceholderForPrecompilation
# end

@setup_workload begin
    ENV["JULIA_CONDAPKG_BACKEND"] = "Null" # use the system installation of Python
    using PythonCall: pyexec

    @compile_workload begin
        # all calls in this block will be precompiled, regardless of whether
        # they belong to this package or not (on Julia 1.8 and higher)
        pyexec(py_precompile_script, PlaceholderForPrecompilation)
    end
end


# try
#     pcl = deserialize("/tmp/precompilation_list.jls")
#     for mi in pcl
#         precompile(mi.specTypes)
#     end
# catch e
#     @show e
# end

end # module PythonCallPrecompileExample

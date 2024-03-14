module PythonCallPrecompileExample

using PrecompileTools


function foo(xs)
    [i*x for (i, x) in enumerate(xs)]
end

# ENV["JULIA_CONDAPKG_BACKEND"] = "Null" # use the system installation of Python
using PythonCall: pyexec, pyexec
# pyexec("import sys; print(sys.executable)", Main)

function get_precompilation()
    pyexec("import sys; print(sys.executable)", Main)

    py_script = """
    import numpy as np
    from juliacall import Main as jl

    jl.seval("using PythonCallPrecompileExample")

    xs = np.random.rand(2, 2)
    ans = jl.PythonCallPrecompileExample.foo(xs)
    """

    Core.Compiler.Timings.reset_timings()
    Core.Compiler.__set_measure_typeinf(true)

    pyexec(py_script, Main)

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

module PlaceholderForPrecompilation
end

# Uncomment this to hook into the precompilation. But it's circular, and it is giving
# Precompiling PythonCallPrecompileExample
#         Info Given PythonCallPrecompileExample was explicitly requested, output will be shown live
# ERROR: LoadError: Python: Julia: Creating a new global in closed module `Main` (`PythonCallPrecompileExample`) breaks incremental compilation because the side effects will not be permanent.

# @setup_workload begin
#     ENV["JULIA_CONDAPKG_BACKEND"] = "Null" # use the system installation of Python
#     using PythonCall: pyexec
#     py_script = """
#     import numpy as np
#     from juliacall import Main as jl

#     jl.seval("using PythonCallPrecompileExample")

#     xs = np.random.rand(2, 2)
#     ans = jl.PythonCallPrecompileExample.foo(xs)
#     """

#     @compile_workload begin
#         # all calls in this block will be precompiled, regardless of whether
#         # they belong to this package or not (on Julia 1.8 and higher)
#         pyexec(py_script, PlaceholderForPrecompilation)
#     end
# end

end # module PythonCallPrecompileExample

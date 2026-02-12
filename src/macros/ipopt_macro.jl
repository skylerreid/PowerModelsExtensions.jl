# optimizer_macros.jl

"""
    @ipopt [tolerance]

Creates an IPOPT solver with predefined settings.
Optional parameter:
- `tolerance`: Convergence tolerance (default: 1e-4)

@ipopt()  # defaults to MA57
@ipopt(1e-4, "ma27")  # smaller problems
@ipopt(1e-3, "mumps")  # fallback
"""
# macro ipopt(tolerance=1e-3)
#     return esc(quote
#         ipopt_solver = optimizer_with_attributes(
#             Ipopt.Optimizer,
#             "tol" => $tolerance,
#             "print_level" => 0,
#             "sb" => "yes"
#         )
#     end)
# end

function build_ipopt_solver(; tolerance=1e-3, linear_solver="ma57")

    solver_options = [
        "tol" => tolerance,
        "print_level" => 5,
        "sb" => "yes",
        "linear_solver" => linear_solver
    ]

    if linear_solver in ("ma27", "ma57", "ma86", "ma97")
        push!(solver_options, "hsllib" => HSL_jll.libhsl_path)
    end

    return optimizer_with_attributes(
        Ipopt.Optimizer,
        solver_options...
    )
end

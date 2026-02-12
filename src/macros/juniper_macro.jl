"""
    @juniper [tolerance]

Creates a Juniper solver with predefined settings.
Optional parameter:
- `tolerance`: Convergence tolerance (default: 1e-4)

Examples:
    @juniper         # Uses default tolerance of 1e-3
    @juniper 1e-2    # Sets tolerance to 1e-2
"""
macro juniper(tolerance=1e-3)
    return esc(quote
        juniper_solver = JuMP.optimizer_with_attributes(
            Juniper.Optimizer,
            "nl_solver" => JuMP.optimizer_with_attributes(
                Ipopt.Optimizer,
                "tol" => $tolerance,
                "print_level" => 5,
                "sb" => "yes",
                "hsllib" => HSL_jll.libhsl_path,
                "linear_solver" => "ma57"
            ),
            "mip_solver" => JuMP.optimizer_with_attributes(
                HiGHS.Optimizer,
                "output_flag" => false
            ),
            "log_levels" => []
        )
    end)
end

# TODO: add highs as a dependency, then I can use this
# function build_juniper_solver(; 
#     tolerance=1e-3,
#     linear_solver="ma57"
# )

#     ipopt_options = [
#         "tol" => tolerance,
#         "print_level" => 5,
#         "sb" => "yes",
#         "linear_solver" => linear_solver
#     ]

#     if linear_solver in ("ma27", "ma57", "ma86", "ma97")
#         push!(ipopt_options, "hsllib" => HSL_jll.libhsl_path)
#     end

#     nl_solver = JuMP.optimizer_with_attributes(
#         Ipopt.Optimizer,
#         ipopt_options...
#     )

#     mip_solver = JuMP.optimizer_with_attributes(
#         HiGHS.Optimizer,
#         "output_flag" => false
#     )

#     return JuMP.optimizer_with_attributes(
#         Juniper.Optimizer,
#         "nl_solver" => nl_solver,
#         "mip_solver" => mip_solver,
#         "log_levels" => []
#     )
# end


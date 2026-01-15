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

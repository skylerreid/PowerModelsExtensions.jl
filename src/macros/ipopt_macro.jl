# optimizer_macros.jl

"""
    @ipopt [tolerance]

Creates an IPOPT solver with predefined settings.
Optional parameter:
- `tolerance`: Convergence tolerance (default: 1e-4)

Examples:
    @ipopt         # Uses default tolerance of 1e-3
    @ipopt 1e-2    # Sets tolerance to 1e-2
"""
macro ipopt(tolerance=1e-3)
    return esc(quote
        ipopt_solver = JuMP.optimizer_with_attributes(
            Ipopt.Optimizer,
            "tol" => $tolerance,
            "print_level" => 0,
            "sb" => "yes"
        )
    end)
end

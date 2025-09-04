# optimizer_macros.jl

"""
    @ipopt

Creates an IPOPT solver with predefined settings.
"""
macro ipopt()
    return esc(quote
        ipopt_solver = JuMP.optimizer_with_attributes(
            Ipopt.Optimizer,
            "tol" => 1e-4,
            "print_level" => 0,
            "sb" => "yes"
        )
    end)
end
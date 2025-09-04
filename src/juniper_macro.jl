"""
    @juniper_minlp

Creates a Juniper MINLP solver with IPOPT as the NLP solver and HiGHS as the MIP solver.
"""
macro juniper_minlp()
    return esc(quote
        ipopt_solver = JuMP.optimizer_with_attributes(
            Ipopt.Optimizer,
            "tol" => 1e-4,
            "print_level" => 0,
            "sb" => "yes"
        )
        
        highs_solver = JuMP.optimizer_with_attributes(HiGHS.Optimizer)
        
        juniper_solver = JuMP.optimizer_with_attributes(
            Juniper.Optimizer,
            "nl_solver" => ipopt_solver,
            "mip_solver" => highs_solver,
            "log_levels" => []
        )
    end)
end
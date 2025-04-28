using PowerModels, JuMP, Ipopt
using MathOptInterface


# Finds the lower bound of real power (Pg) for specified generators
# before the power flow solution fails.  Uses a bisection search.
# function assumes that the input case solves with the default reactive power levels

function find_pg_limit(case::Dict, gen_indices::Vector{Int}, tolerance::Float64)
    # Configure local setting for GIC solver
    setting = Dict{String,Any}("output" => Dict{String,Any}("branch_flows" => true))
    local_setting = Dict{String,Any}("bound_voltage" => true)
    merge!(local_setting, setting)
    solver = JuMP.optimizer_with_attributes(Ipopt.Optimizer, "tol" => 1e-4, "print_level" => 0, "sb" => "yes")
    # Define the power flow function
    function power_flow_tf(pm_case::Dict) #determine if power flow solves or not
        result = solve_ac_opf(pm_case, solver)
        if haskey(result, "termination_status") && result["termination_status"] == MathOptInterface.LOCALLY_SOLVED
            return true
        else
            return false
        end
    end

    output = 0.0

    pg_mult_low = 0.0
    pg_mult_high = 1.0
    iters = 0

    # Check if the power flow solves with zero reactive power
    temp_case_zero_pg = deepcopy(case)
    modify_gens(temp_case_zero_pg, gen_indices, 0.0, 1.0)
    if power_flow_tf(temp_case_zero_pg)
        println("Power flow solves with zero real power for the specified generators. No lower limit found.")
        return output
    end

    while (pg_mult_high - pg_mult_low) > tolerance
        pg_mult_mid = (pg_mult_low + pg_mult_high) / 2.0
        temp_case = deepcopy(case) # Create copy of the case
        modify_gens(temp_case, gen_indices, pg_mult_mid, 1.0)
        iters = iters+1
        if power_flow_tf(temp_case)
            # If power flow is successful, lower the limit
            pg_mult_high = pg_mult_mid
        else
            # If power flow fails, raise the lower limit
            pg_mult_low = pg_mult_mid
        end
    end

    output = pg_mult_low

    # if isempty(results) && !isempty(gen_indices)
    #     println("Bracketing failed to find a lower limit for the combined Qg of the specified generators.")
    # end
    println("Solution found after $iters bracketing iterations")
    return output
end
function modify_gens(case::Dict, gen_indices::Vector{Int}, p_multiplier::Float64, q_multiplier::Float64)
    println("Adjusted generators:")
    for gen_index in gen_indices
        if haskey(case["gen"], string(gen_index)) # Use string(gen_index) because keys in case["gen"] are strings
            gen_data = case["gen"][string(gen_index)]
            gen_data["pg"] *= p_multiplier
            gen_data["pmax"] *= p_multiplier
            gen_data["pmin"] *= p_multiplier
            gen_data["qg"] *= q_multiplier
            gen_data["qmax"] *= q_multiplier
            gen_data["qmin"] *= q_multiplier
            println(gen_index)
        else
            println("Generator $gen_index not found in the case data.")
        end
    end
end

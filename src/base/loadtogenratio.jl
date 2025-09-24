function loadtogenratio(case)

    pload = 0.0
    qload = 0.0
    pgen = 0.0
    qgen = 0.0

    # Access loads using the same logic as modify_loads
    for (bus_num, load_data) in case["load"]
        pload += load_data["pd"]
        qload += load_data["qd"]
    end

    # Access generators using the same logic as modify_gens
    for (gen_num_str, gen_data) in case["gen"]
        pgen += gen_data["pg"]
        qgen += gen_data["qg"]
    end

    pratio = pload / pgen
    qratio = qload / qgen

    return pratio, qratio
end
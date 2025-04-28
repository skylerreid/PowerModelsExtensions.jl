function modify_loads(case::Dict, lat_min::Float64, lat_max::Float64, long_min::Float64, long_max::Float64, multiplier::Float64)
    println("Adjusted buses:")
    for (bus_num, bus_data) in case["bus"]
        lat = bus_data["lat"]
        lon = bus_data["lon"]

        if lat_min <= lat <= lat_max && long_min <= lon <= long_max
            if haskey(case["load"], bus_num)
                bus_load = case["load"][bus_num]
                bus_load["pd"] *= multiplier
                bus_load["qd"] *= multiplier
                println(bus_num)
            end
        end
    end
end
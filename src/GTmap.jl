using Shapefile
using DataFrames
using Plots

function GTmap(State::String, case::Dict, shp_path::String, width::Int, height::Int, title::String)
    #----------Plot State Outline------------------
    shp = Shapefile.Table(shp_path)
    p = state_plot(State, width, height, title, shp_path)

    #------figure out which buses are gens----------------
    gens_list = Int[]
    for gen_id in keys(case["gen"])
        push!(gens_list, case["gen"][gen_id]["gen_bus"])
    end

    #----------extract coords for gens----------
    gens_lats = Float32[]
    gens_lons = Float32[]
    for (bus_number_str, bus_info) in case["bus"] # loop through key-value pairs
        bus_number = parse(Int, bus_number_str)
        # Check if this bus number is associated with a generator
        for gen_bus in gens_list
            if gen_bus == bus_number
                lat = bus_info["lat"]
                lon = bus_info["lon"]
                push!(gens_lats, lat)
                push!(gens_lons, lon)
                break # move on to next generator
            end
        end
    end
    println("Generators connected to buses: ", gens_list)   # print generator buses

    #----------extract lines from branch data (to and from vectors)----------
    froms = Int[]
    tos = Int[]
    #line i goes from froms[i] to tos[i]
    for (branch_id, branch_info) in case["branch"]
        # Check if the branch is not a transformer
        if !haskey(branch_info, "transformer") || (haskey(branch_info, "transformer") && !branch_info["transformer"])
            from_bus = branch_info["f_bus"]
            to_bus = branch_info["t_bus"]
            push!(froms, from_bus)
            push!(tos, to_bus)
        end
    end

    if isempty(froms)||isempty(tos)
        println("error: branch data not detected properly")
        println(froms)
     #line i goes from froms[i] to tos[i]
        for (branch_id, branch_info) in case["branch"]
        # Check if the branch is not a transformer
            if !haskey(branch_info, "transformer") || (haskey(branch_info, "transformer") && !branch_info["transformer"])
                from_bus = branch_info["hi_bus"]
                to_bus = branch_info["lo_bus"]
                push!(froms, from_bus)
                push!(tos, to_bus)
            end
         end
    end

    if isempty(froms)||isempty(tos)
        println("branch data still not detected properly")
    end

    #plot a line from froms(i) to tos(i)
    for i in 1:(length(froms))
        from_bus_num = froms[i]
        to_bus_num = tos[i]

        from_bus_str = string(from_bus_num)
        to_bus_str = string(to_bus_num)

        if haskey(case["bus"], from_bus_str) && haskey(case["bus"], to_bus_str)
            from_lat = case["bus"][from_bus_str]["lat"]
            from_lon = case["bus"][from_bus_str]["lon"]
            to_lat = case["bus"][to_bus_str]["lat"]
            to_lon = case["bus"][to_bus_str]["lon"]

            plot!(p, [from_lon, to_lon], [from_lat, to_lat],
                  color=:blue, linewidth=1, label="") # Label set to "" to avoid multiple entries in legend
        else
            println("Warning: Could not find coordinates for bus(es) in froms[$i] ($(from_bus_num)) or tos[$i] ($(to_bus_num)).")
        end
    end

    scatter!(p, gens_lons, gens_lats, markersize=5, color=:red, label="Generators")

    return p
end

# Example Usage (assuming network_case is defined):
# state_name = "Tennessee"
# plot_title = "Power Grid in Tennessee"
# plot_height = 600
# plot_width = 1000

# power_grid_map = GTmap(state_name, network_case, plot_height, plot_width, plot_title)
# display(power_grid_map)
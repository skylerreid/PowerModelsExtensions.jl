module PowerModelsExtensions

__precompile__()

using PowerModels, MathOptInterface, JuMP, Ipopt

include("base/find_qg_limit.jl")
include("base/find_pg_limit.jl")
include("base/modify_loads.jl")
include("base/modify_gens.jl")
include("base/loadtogenratio.jl")
#include("plotting/state_plot.jl")
#include("plotting/GTmap.jl")
include("base/correct_power_factor.jl")
include("base/longline_sending_voltage.jl")
include("base/match_admittance.jl")
include("base/projectilestats.jl")
include("macros/ipopt_macro.jl")
include("macros/juniper_macro.jl")
include("utilities/get_files_by_extension.jl")
include("compiled/curves_wrapper.jl")
include("macros/json_macro.jl")

export correct_power_factor,
       find_qg_limit,
       find_pg_limit,
       modify_loads,
       modify_gens,
       load_to_gen_ratio, 
       longline_sending_voltage,
       match_admittance,
       projectilestats,
       @ipopt,
       @juniper,
       @to_json,
       get_files_by_extension,
       z_index,
       hilbert_index
end



module PowerModelsExtensions

__precompile__()

using PowerModels, MathOptInterface, JuMP, Ipopt

include("find_qg_limit.jl")
include("find_pg_limit.jl")
include("modify_loads.jl")
include("modify_gens.jl")
include("loadtogenratio.jl")
#include("state_plot.jl")
#include("GTmap.jl")
include("correct_power_factor.jl")
include("longline_sending_voltage.jl")
include("match_admittance.jl")
include("projectilestats.jl")
include("ipopt_macro.jl")
include("juniper_macro.jl")
include("get_files_by_extension.jl")
include("curves_wrapper.jl")

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
       @juniper_minlp,
       get_files_by_extension,
       z_index,
       hilbert_index
end


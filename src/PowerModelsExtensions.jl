module PowerModelsExtensions

__precompile__()

using PowerModels, MathOptInterface, JuMP, Ipopt, HTTP, JSON, HiGHS
using HSL_jll, Juniper

const hslpath = HSL_jll.libhsl_path

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
include("utilities/generic.jl")
include("utilities/get_no_reason.jl")
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
       build_ipopt_solver,
       build_juniper_solver,
       @juniper, #planning to eventually switch this from macro to function
       to_json!,
       get_files_by_extension,
       get_no,
       filetype,
       force_recompile,
       z_index,
       hilbert_index
end



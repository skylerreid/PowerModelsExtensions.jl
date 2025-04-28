# PowerModelsExtensions.jl

Additional functions for PowerModels.jl

Welcome to PowerModelsExtensions!

## Installation

To install:

```julia
using Pkg

Pkg.add(url="[https://github.com/skylerreid/PowerModelsExtensions.jl](https://github.com/skylerreid/PowerModelsExtensions.jl)")'''

#Available functions: 

loadtogenratio: takes in a PowerModels case. Sums the real and reactive power at both the loads and the generators. Returns a 2x1 Float64 with the ratios of these quantities. 

find_qg_limit and find_pg_limit: takes in a PowerModels case, a vector of generator indices (Int) and a tolerance value. Finds the lower limit of reactive or real power before a PowerModels AC OPF no longer solves. Uses a bisection search to adjust the outputs of the specified generators until the gap between the high and low values is less than the tolerance. Before entering the main loop, the function runs a power flow with the generator parameters set to zero. If the system solves with zero reactive power, the function returns 0.0 and prints "The case solves with zero reactive power at the specified generators. No lower limit found." If the power flow does not solve at zero, the bisection search is performed and the number of iterations is printed. 

example: 
q_lim = find_qg_limit(case1, [1,2,3,4,5,6,7,8,9,10], 0.01) #find reactive power limit for gens 1-10 with 0.01 tolerance


modify_gens: scales the pg and qg values at a list of specified generators. This function modifies the case in place, so a copy should be performed if the case is needed later. 

example:
modify_gens(case, [1,2,3,4,5,6], 1.0, 0.8) #reduce reactive power in gens 1-5 by 20% without adjusting real power

modify_loads: similar to modify_gens, this function takes in four coordinates outlining a rectangle and adjusts the loads at any bus inside that region. It also modifies the case in place, so a copy should be performed if the case is needed later. 

example:
modify_loads(case, latmin, latmax, longmin, longmax, 0.9) #scales both p and q at each bus in the region by 0.9

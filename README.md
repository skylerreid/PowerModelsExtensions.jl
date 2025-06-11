# PowerModelsExtensions.jl

Additional functions for PowerModels.jl

Welcome to PowerModelsExtensions!

## Installation

To install:

```julia
using Pkg

Pkg.add(url="https://github.com/skylerreid/PowerModelsExtensions.jl")
```

## Available functions: 

loadtogenratio: takes in a PowerModels case. Sums the real and reactive power at both the loads and the generators. Returns a 2x1 Float64 with the ratios of these quantities. 

```julia
ratio = loadtogenratio(case1)
```

find_qg_limit and find_pg_limit: takes in a PowerModels case, a vector of generator indices (Int) and a tolerance value. Finds the lower limit of reactive or real power before a PowerModels AC OPF no longer solves. Uses a bisection search to adjust the outputs of the specified generators until the gap between the high and low values is less than the tolerance. Before entering the main loop, the function runs a power flow with the generator parameters set to zero. If the system solves with zero reactive power, the function returns 0.0 and prints "The case solves with zero reactive power at the specified generators. No lower limit found." If the power flow does not solve at zero, the bisection search is performed and the number of iterations is printed. 

example: 
```julia
q_lim = find_qg_limit(case1, [1,2,3,4,5,6,7,8,9,10], 0.01) #find reactive power limit for gens 1-10 with 0.01 tolerance
```

modify_gens: scales the pg and qg values at a list of specified generators. This function modifies the case in place, so a copy should be performed if the case is needed later. 

example:
```julia
modify_gens(case, [1,2,3,4,5,6], 1.0, 0.8) #reduce reactive power in gens 1-5 by 20% without adjusting real power
```

modify_loads: similar to modify_gens, this function takes in four coordinates outlining a rectangle and adjusts the loads at any bus inside that region. It also modifies the case in place, so a copy should be performed if the case is needed later. 

example:
```julia
modify_loads(case, latmin, latmax, longmin, longmax, 0.9) #scales both p and q at each bus in the region by 0.9
```

GTmap: takes a PowerModels case and extracts the generator locations from the bus data. The branch data can be used to infer the transmission line lengths and endpoints. Requires a specific shapefile that can be found in my geodata plots repo. note: this function is currently disabled in the main PME package. It can still be accessed and used, but will need to be copied to your local machine.

example:
```julia
using PowerModels
shp_path = "C:\\Users\\skyle\\OneDrive - Montana State University\\EELE 491\\data\\ne_110m_admin_1_states_provinces.shp"
case_path = "C:\\Users\\skyle\\OneDrive - Montana State University\\EELE 491\\150_sync\\uiuc150bus_10.m"
case = parse_file(case_path)

p1 = GTmap("TN", case, shp_path, 1200, 600, "TN Test Grid G&T")

display(p1)
```

correct_power_factor: performs basic power factor correction. Takes the source voltage, real power, current power factor, lead or lag (as a string), and the desired power factor. Frequency defaults to 60Hz. Returns the element needed for power factor correction. 
example with a 10kV source supplying 50kW at 0.6 lagging, corrected to 0.9: 
```julia
capacitor_value = correct_power_factor(1e4, 5e4, 0.6, "lag", 0.9)
```

match_admittance: performs basic single-stub admittance matching using the Smith chart method. Returns a tuple containing the location and component pairs that match admittances. Distances are in meters. In the example case, the function returns (d1 = -0.8800158406356422, component1 = ("C", 1.4379774886996293e-11), d2 = 0.18939097687649034, component2 = ("L", 1.7615224236570468e-7))
example for a 25-j50 ohm line with 50 ohms characteristic impedance, operating at 100MHz: 
```julia
matched = = match_admittance(25-im*50, 50.0, 100e6)
```

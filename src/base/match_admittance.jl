#single-stub admittance matching using Smith chart method
function match_admittance(Z_line::Complex, Z_0::Real, frequency::Real)
    c = 3e8
    λ = c / frequency
    β = 2π / λ

    Y_line = 1 / Z_line #impedance to admittance
    YL_normalized = Y_line * Z_0

    Γ = (1 - YL_normalized) / (1 + YL_normalized) #reflection coeff
    Γ_mag = abs(Γ)
    θ_Γ = angle(Γ)

    θ′ = acos(-Γ_mag)

    d1 = (θ_Γ - θ′) / (2 * β) #possible locations for admittance matching
    d2 = (θ_Γ + θ′) / (2 * β)

    function input_admittance(Γ_mag, θ′) #helper function
        denom = 1 + Γ_mag^2 - 2*Γ_mag*cos(θ′)
        G = (1 - Γ_mag^2) / denom
        B = (-2 * Γ_mag * sin(θ′)) / denom
        return G + im*B
    end

    Yd1 = input_admittance(Γ_mag, θ′) #evaluate at +- θ'
    Yd2 = input_admittance(Γ_mag, -θ′)

    B_stub1 = -imag(Yd1)
    B_stub2 = -imag(Yd2)

    ω = 2π * frequency

    # Unnormalize
    B1_actual = B_stub1 / Z_0
    B2_actual = B_stub2 / Z_0

    component1 = B1_actual > 0 ? ("C", B1_actual / ω) : ("L", -1 / (ω * B1_actual))
    component2 = B2_actual > 0 ? ("C", B2_actual / ω) : ("L", -1 / (ω * B2_actual))

    #return tuple with locations and component values
    return (
    d1 = d1, component1 = component1,
    d2 = d2, component2 = component2
    )

end
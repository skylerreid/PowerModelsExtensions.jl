function correct_power_factor(Vs, Pl, pf_current, leadlag::String, pf_desired, f=60)
    if leadlag == "lag"
        theta = acos(pf_current)
        Q_old = Pl * tan(theta)

        theta_new = acos(pf_desired)
        Q_new = Pl * tan(theta_new)

        Q_c = Q_new - Q_old #how much power has to be supplied by capacitor
        chi_c = (Vs^2)/Q_c 

        C = abs(1/(chi_c*2*f*pi)) #find actual capacitor value
        return C
    

    elseif leadlag == "lead"
        theta_current = acos(pf_current)
        Q_old = Pl * tan(-theta_current) # will be negative

        theta_desired = acos(pf_desired)
        Q_new = Pl * tan(-theta_desired) 

        Q_c = Q_new - Q_old
        chi_L = (Vs^2)/Q_c

        # Inductance L = chi_L / (2*pi*f)
        L = chi_L / (2*f*pi)
        return L
    else
        println("input 'lead' or 'lag' as a string")
        return 0
    end
    

end
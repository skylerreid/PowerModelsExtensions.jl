#calculate the voltage along a line (length>250km) given the line characteristics and voltage on the receiving end
function longline_sending_voltage(R, L, G, C, V_R, I_R, length, f=60)
    #solve for line parameters first
    w = 2*f*pi
    z = R+(im*w*L)
    y = G+(im*w*C)

    z_c = (z/y)^0.5
    gamma = (z*y)^0.5

    #calculate matrix components
    A = cosh(gamma*length)
    B = z_c*sinh(gamma*length)
    C = sinh(gamma*length)/z_c
    D = A

    #solve matrix
    output = [A B; C D]\[V_R; I_R]
    return output

end

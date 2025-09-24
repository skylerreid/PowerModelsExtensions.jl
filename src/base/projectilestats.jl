#calculate the distance traveled by a projectile fired upward at a certain angle and velocity
#inputs: angle, speed, initial launch height above landing surface

function projectilestats(speed, angle, start_height)

    g = 9.80665
    angle = deg2rad(angle)
    horz_speed = speed*cos(angle)
    vert_speed = speed*sin(angle)

    rise_height = (vert_speed^2)/(2*g)
    rise_time = (2*rise_height)/(vert_speed)

    fall_time = sqrt(2*(start_height + rise_height)/g)
    time_of_flight = rise_time+fall_time

    range = (time_of_flight)*horz_speed
    
    return [range, time_of_flight, rise_height]

end
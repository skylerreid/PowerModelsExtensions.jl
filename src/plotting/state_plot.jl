function state_plot(PostalAbbreviation::String, height::Int, width::Int, title::String, x_label::String="Latitude", y_label::String="Longitude", shp_path::String="C:\\Users\\skyle\\OneDrive - Montana State University\\EELE 491\\data\\ne_110m_admin_1_states_provinces.shp", postal_code_column::String="postal")
    shp = Shapefile.Table(shp_path)
    df = DataFrame(shp)

    state_df = filter(row -> row[postal_code_column] == PostalAbbreviation, df) # Changed filtering column and argument name
    p = plot(aspect_ratio=:equal, size = (height, width), title = title, xlabel = x_label, ylabel = y_label)
    for geom in state_df.geometry
        plot!(p, geom, color=:lightgray, lw=1, label=false)
    end

    return p
end
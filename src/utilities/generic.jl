#super basic little guy to get a file type
filetype(filename::String) = split(lowercase(filename), '.')[end]

#make an imported package re load
force_recompile(package_name::String) = Base.compilecache(Base.identify_package(package_name))

function keys_to_symbols(old_dict::Dict{String, Any})::Dict{Symbol, Any}
    #kind of dumb method for converting all dict keys to strings
    new_dict = Dict{Symbol, Any}()
    for (k, v) in pairs(old_dict)
        new_key = Symbol(k)
        if isa(v, AbstractDict)
            new_dict[new_key] = keys_to_symbols(v)
        else
            new_dict[new_key] = v
        end
    end
    return new_dict
end
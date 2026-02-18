#super basic little guy to get a file type
filetype(filename::String) = split(lowercase(filename), '.')[end]

#make an imported package re load
force_recompile(package_name::String) = Base.compilecache(Base.identify_package(package_name))
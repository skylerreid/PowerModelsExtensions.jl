#super basic little guy to get a file type
filetype(filename::String) = split(lowercase(filename), '.')[end]

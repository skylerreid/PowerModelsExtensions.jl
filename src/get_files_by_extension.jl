function get_files_by_extension(directory_path::String, extension::String)
    all_files_and_dirs = readdir(directory_path, join = true)
    filtered_files = filter(x -> endswith(lowercase(x), lowercase(extension)), all_files_and_dirs)
    return filtered_files
end
"""
    @to_json filepath object

Writes the `object` to the file specified by `filepath` with an indentation of 2.

Note: This macro relies on the `JSON` package being available in the environment.
"""
macro to_json(filepath, object)
    indent_val = 2
    
    esc_filepath = esc(filepath)
    esc_object = esc(object)

    return quote
        Base.open($esc_filepath, "w") do io
            JSON.print(io, $esc_object, $indent_val)
        end
    end
end
function get_no()
    response = HTTP.get("https://naas.isalman.dev/no")
    data = JSON.parse(String(response.body))
    return data["reason"]
end
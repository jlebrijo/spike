def body_hash
  JSON.parse(response.body, symbolize_names: true) if response.body.length >= 2
end

def print_body
  puts JSON.pretty_generate body_hash
end

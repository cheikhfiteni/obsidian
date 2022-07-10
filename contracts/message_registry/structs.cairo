%lang starknet

#struct for sentence phrase felt packing. flow is encrypt --> chat str_felt conversion --> struct packing
struct MessagePacked:
    member sender : felt
    member timestamp : felt
    member message_high : felt 
    member message_mid : felt #is there a  way to *args this?
    member message_low : felt 
end

# Struct to store messages and the time they were published.
struct Message:
    member message : felt #after compile works this should be MessagePacked
    member timestamp : felt
end

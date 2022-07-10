%lang starknet

struct Player:
    member address_id : felt
    member role : felt
    member is_dead : felt
end

struct Game:
    member players_len : felt
    member players : Player*
    member is_ended : felt
    member index : felt
end
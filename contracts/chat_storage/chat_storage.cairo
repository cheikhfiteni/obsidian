%lang starknet

from starkware.starknet.common.syscalls import get_caller_address, get_block_timestamp
#use get_block_timestamp to make sure that a message isn't being published in the future.

#Struct for lookup of public keys; struct imports
from structs import MessagePacked, Message

#needed for the building messages helper function.
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin



#
# Storage 
#


# Storage var to map account to their messages.
# res := (messages_count : felt, messages : Message*)
# The return type of storage variables must be a felts-only type (cannot contain pointers).
# Just need seperate storage for the len, can use same struct for day or night, use 0 or 1 like true or false

#alternatively can group the messages by 30 second intervals and overwrite them for each round (so say 10 in max 30 seconds)

@storage_var 
func message_len_storage(isDay : felt) -> (messages_len : felt):
end

##should we structure this where night and name are the hash?)

@storage_var
func message_storage(messages_len : felt) -> (message : Message):
end

@storage_var
func night_messages_storage(messages_len : felt) -> (message : Message):
end


#
#Getters: all @view; 
#

# Reads a message at a specified timestamp.
@external
func read_message_at_timestamp{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    isDay : felt, timestamp : felt
) -> (messages_len : felt, messages : Message*):
    let(messages) = alloc()
    let (len_ptr) = message_len_storage.read(isDay)
    #oh so as L54 was before it would parse returned collection messages for sender. Instead we need to call all according to 
    #what is available. Think a get all publishers contract. Need to change the logic of the helper bc len_ptr is not a pointer
    let (_, messages) = read_message_at_timestamp_helper(account_id, timestamp, len_ptr[0], len_ptr[1])
    return (messages)
end

# Recursive helper function for read_message_at_timestamp
func read_message_at_timestamp_helper(
    account_id : felt, 
    timestamp : felt, 
    messages_len : felt, 
    messages : Message*
) -> (messages_len : felt, messages : Message*):
    tempvar time = messages.timestamp
    if time == timestamp:
        return (messages_len, messages_len)
    end
    # TODO add greater than functionality.
    if messages_len == 0:
        return (0, 0)
    end
    return (
        read_message_at_timestamp_helper(account_id, timestamp, messages_len - Message.SIZE, messages + Message.SIZE),
    )
end

#
# Setters: all @external; have an add and a set
# 

# Writes a message to message_storage.
@external
func write_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    account_id : felt, message : felt, timestamp : felt
):
    let message_instance = Message(message=message, timestamp=timestamp)
    let (message_count_message) = message_storage.read(account_id)
    message_storage.write(account_id, message_count_message[0] + Message.SIZE, message_instance)
end



#  let (current_timestamp) = get_block_timestamp()
#             with_attr error_message("ChatStorage: message timestamp is in the future"):
#                 let (is_future_message) = is_le(current_timestamp, message.timestamp)
#                 assert is_future_expired = FALSE
#             end
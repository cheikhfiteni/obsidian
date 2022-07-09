%lang starknet

from starkware.starknet.common.syscalls import get_caller_address, storage_read, storage_write
#from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Struct to store messages and the time they were published.
struct Message:
    member message : felt
    member timestamp : felt
end

# Storage var to map account to their messages.
# res := (messages_count : felt, messages : Message*)
@storage_var
func message_storage(account_id : felt) -> (res : (felt, felt)):
end

# Writes a message to message_storage.
@external
func write_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    account_id : felt, message : felt, timestamp : felt
):
    let (message_instance) = Message(message=message, timestamp=timestamp)
    let (message_count_message) = message_storage.read(account_id)
    message_storage.write(account_id, message_count_message[0] + Message.SIZE, message_instance)
end

# Reads a message at a specified timestamp.
@external
func read_message_at_timestamp{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    account_id : felt, timestamp : felt
) -> (messages : Message*):
    assert (len_ptr) = message_storage.read(account_id)
    assert (_, messages) = read_message_at_timestamp_helper(account_id, timestamp, len_ptr[0], len_ptr[1])
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

%lang starknet

# Not all imports are used yet.
from starkware.starknet.common.syscalls import get_caller_address, storage_read, storage_write
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Struct to store messages and the time they were published.
struct Message:
    member message : felt
    member timestamp : felt
end

# Storage var to map account to their messages.
@storage_var
func message_storage(account_id : felt) -> (messages : Message*):
end

# Writes a message to message_storage.
@external
func write_message{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(account_id : felt, message : felt, timestamp : felt):
    let message_instance = Message(
        message=message, timestamp=timestamp
    )
    message_storage.write(account_id, message_instance)
    return () # Do I need this return?
end

# Reads a message at a specified timestamp.
@external
func read_message_at_timestamp{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
    }(account_id : felt, timestamp : felt) -> (messages : Message*):
    assert (ptr : Message*, len : felt) = message_storage(account_id)
    assert (messages, _) = read_message_at_timestamp_helper(account_id, timestamp, ptr, len)
    return (messages)
end

# Recursive helper function for read_message_at_timestamp
@internal
func read_message_at_timestamp_helper(
    account_id : felt, 
    timestamp : felt,
    messages : Message*,
    messages_len : felt
    ) -> (messages : Message*, message_len : felt):
    tempvar time : felt = messages.timestamp
    if time == timestamp:
        return (messages, message_len)
    if messages_len == 0: # TODO add greater than functionality.
        return (0, 0)
    return (read_message_at_timestamp_helper(account_id, timestamp, messages + Message.SIZE, messages_len - Message.SIZE))
end
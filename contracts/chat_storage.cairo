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
@storage_var
func message_storage(account_id : felt) -> (messages : felt):
end

# Storage var to map account to message count.
@storage_var
func message_count_storage(account_id : felt) -> (len : felt):
end

# Writes a message to message_storage.
@external
func write_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    account_id : felt, message : felt, timestamp : felt
):
    let message_instance = Message(message=message, timestamp=timestamp)
    assert message_count = message_count_storage.read(account_id)
    message_storage.write(account_id, message_instance)
    message_count_storage.write(account_id, message_count + Message.SIZE)
end

# Reads a message at a specified timestamp.
@external
func read_message_at_timestamp{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    account_id : felt, timestamp : felt
) -> (messages : Message*):
    assert (ptr) = message_storage.read(account_id)
    assert (len) = message_count_storage.read(account_id)
    assert (messages, _) = read_message_at_timestamp_helper(account_id, timestamp, ptr, len)
    return (messages)
end

# Recursive helper function for read_message_at_timestamp
func read_message_at_timestamp_helper(
    account_id : felt, timestamp : felt, messages : Message*, messages_len : felt
) -> (messages : Message*, message_len : felt):
    tempvar time : felt = messages.timestamp
    if time == timestamp:
        return (messages, message_len)
    end
    # TODO add greater than functionality.
    if messages_len == 0:
        return (0, 0)
    end
    return (
        read_message_at_timestamp_helper(account_id, timestamp, messages + Message.SIZE, messages_len - Message.SIZE),
    )
end

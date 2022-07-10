#Give the same functionality as onlyOwner() in a solidity contract. Specifies which Account is admin 
#Manage proxy upgrades to depployer contracts (so whatever we use to interact with message registry 

# Permissioned calls will be 
# writing over chat again at the end of each round to encourage light chat persisence (this could be done automatically by checking clock)
# 

from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import HashBuiltin

#
# Storage
#

@storage_var
func Admin_admin_address_storage() -> (admin_address : felt):
end


#
# Constructor
#

func Admin_initialize_admin_address{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(admin_address : felt):
    let (existing_admin_address) = Admin_admin_address_storage.read()
    with_attr error_message("Admin: Admin address is already initialized"):
        assert existing_admin_address = 0
    end

    Admin_admin_address_storage.write(admin_address)
    return ()
end

#
# Getters
#

func Admin_get_admin_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        ) -> (admin_address : felt):
    let (admin_address) = Admin_admin_address_storage.read()
    return (admin_address)
end

#
# Setters
#

func Admin_set_admin_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        new_address : felt):
    let (old_admin_address) = Admin_admin_address_storage.read()
    Admin_admin_address_storage.write(new_address)
    UpdatedAdminAddress.emit(old_admin_address, new_address)
    return ()
end

#
# Guards
#

func Admin_only_admin{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    let (caller_address) = get_caller_address()
    let (admin_address) = Admin_admin_address_storage.read()
    with_attr error_message("Admin: Called by non-admin contract"):
        assert caller_address = admin_address
    end
    return ()
end


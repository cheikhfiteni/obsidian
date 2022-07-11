%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import deploy

#
# Storage Variables
#

@storage_var
func salt() -> (value : felt):
end

@storage_var
func admin_class_hash() -> (value : felt):
end

#
# Events
#

@event
func administered_contract_deployed(contract_address : felt):
end

#
# Constructor
#

@constructor
func constructor{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(admin_class_hash_ : felt):
    admin_class_hash.write(value=admin_class_hash_)
    return ()
end

#
# External
#

@external
func deploy_new_game{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*, 
    range_check_ptr
    }(admin_address : felt):
        let (current_salt) = salt.read()
        let (class_hash) = admin_class_hash.read()
        let (contract_address) = deploy(
            class_hash=class_hash,
            contract_address_salt=current_salt,
            constructor_calldata_size=1,
            constructor_calldata=cast(new (admin_address,), felt*),
        )
        salt.write(value=current_salt + 1)

        administered_contract_deployed.emit(
            contract_address=contract_address
        )
        return ()
end
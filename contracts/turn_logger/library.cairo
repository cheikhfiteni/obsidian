# This should work on validating rounds and saying who died each day

# Assign roles, or don't? Figure out who won?


#FLOW
#D0 ---> N1 ---> D1 ---> N2 ----> D2

#Build for arbritrary Game of 8-12 
#Jester. Executioner. Invest. Three other two. Two-three mobsters. 


#Roles help include win conditions and choose who won at end? Instead of having game terminate at whatever

#Is will writing managed here or in account? Is role managed here or in account?
#Role management needs to be handled like address-->name--> role. Is there a way to anonymize this?
#Have it be the hashed address is the only way to call it, but you'll see what the address calling it is (who the account is)
#Could it be that you have address passed in with a random prime off chain determines returns on_chain name, but you'd never see
#and address pased in with different random prime off chain returns role? But do you see in the explorer who that is?
#What about shipping first. Thinking about anonymity at the end

#
# Events
#

@events
func WinnerDeclared(day : felt, role : felt, winner : felt):
end 

#
# Storage
#

@storage_var
func character_will_storage(address : felt) -> (will : WillStruct):
end

##require a with attr asser that caller sender is the person will holder
#ohh something that might be useful to help anonymize things is the frontend can handle resolving 
#account addresses to names. And that way they couldn't figure out who is who except by cross-referencing
#addr and name. That is acceptable IMO for the interim


#
# Constructor
#

#Initialize an only admin for these cases. Deploy new contracts if need be to set up the game.
#Find a way to clear everything at the end (feature) or keep everything forever on chain?



#
# Getters; pull ABI objects on time? 
#

#Figure out how many people are still alive. 
#Recieve the nightly death
#Recieve the nightly hannging. 
#Can store will's so they persist between rounds
    #Hash the name as an indentifier


#
# Setters; set the key 
#


#
# Business Logic 
#


#OnlyAdmin() callable function that checks if game is over. At the end of the game based on what is happening
#Then figure out if a win condition is reached. The client is runs the Admin account and checks
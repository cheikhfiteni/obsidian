## MatchboxDAO Hackathon Potential Project #1
---

MatchboxDAO Hackathon Details: [link](https://www.matchboxdao.com/) 
<br>
Discord link: [link]()


Abstract: Create a privacy focused gaming primitive centered on the ability to randomly listen in or capture "bits" from an opponents in-chain chat. 

Establishing a standard for "pourous" in-game communication would lay the foundation for a next generation of espionage-themed games (with counter survelliance elements), add a new dimension to existing coordination-based boardgames like Diplomacy/Mafia, and/or define the core functionality for a class of characters in RPG card games and/or MMOs which have a "mind read ability."

I want to prioritize thinking about game features which will be exclusively possible because of ZK technology. Until now unexplored features have been info-capture or chain verifiable ease-dropping that is limited in a mathematical way. Idk the feasibility of this, but if anyone wants to try building that (I think using hash collusions on each word with a cryptography backdoor that reduces entropy via an RLN) feel free to contribute or DM me on Twitter @itsonlysoleil. 

#### **Early Implementation Details**

To flesh this out more, have every 5 words encrypted by 5 private keys, and have the game frontend abstract that all away. Basically if you upgrade your skill tree enough you add an RLN to your opponent's chat (which up to this point you can think of as PGP or AES encrypted, with their keys created via DIffe-Helman or something at the start of the round and stored on their local game client or frontend). As your skill tree advances you get access to every other word in their chat, or every 2/5 words, or eventually 5/5, and it becomes this interesting component to asymmetric information communication games like Mafia or Diplomacy (think party games among strangers).


Again focus on building the minimum viable product feature and I think lots of people would compose on that standard. Also introduces new game theoretic play where the longer the gameplay goes on for in theory, your opponent players will be more covered in how they chat because the possibility that someone has access to chat words goes up. This can be balanced by a higher (or quadratic) cost to unlocking the last 'pareto' distributed scope over opponent's speech, so as to make it a point tradeoff to spec into these components completely.

Also the hashing can be randomized what is the fifth word or what is the second word so you can't just make sure your consistent 2nd word isn't bad.

Ik a lot of hashing primitives are underdeveloped on starkware but I think there's enough for a proof of concept, and if all else fails we can define implementations for the standards that would make this core feature for many games possible in the future

Please let me know if you are interested in building this project by Friday July 1st, and see contact details above. 

#### **Asymetric Information Games to Playtest/Extend**

- [Town of Salem](https://www.blankmediagames.com/) Basically Mafia/Werewolf the party game online
- [Backstabbr](https://www.backstabbr.com/) Diplomacy Online w/ good sandboxes to iterate on turn-based communication point. 

MatchboxDAO's hackathon invites devs working on new gaming primitives to experiment with Cairo. 
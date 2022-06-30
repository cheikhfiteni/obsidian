## MatchboxDAO Hackathon Potential Project #1
---

MatchboxDAO Hackathon Details: [link](https://www.matchboxdao.com/) 
<br>
Discord link: [link]()


Abstract: Create a "pourous" privacy focused gaming primitive centered on the ability to randomly listen in or capture "bits" from an opponents in-chain chat. 

Establishing a standard for in-game communication would lay the foundation for a next generation of espionage-themed games (with counter survelliance elements), add a new dimension to existing coordination-based boardgames like Diplomacy/Mafia, and/or define the core functionality for a class of characters in RPG card games and/or MMOs which have a "mind read ability."

We want to prioritize thinking about game features are inherently made possible by the recent advancements in zero-knowledge technology. Until now, features like leaky info-capture or chain verifiable ease-dropping (limited in a mathematical way), have been unexplored in the context of games. Our current approach will be to intiate hash collusions on each word with a cryptographic backdoor that reduces entropy via a [rate-limiting nullifier](https://twitter.com/vacp2p/status/1504782393730736128?s=20&t=7i9pwJdVpt94-X2qI3x3lw) (RLN). 

_If you're interested in building this product for the MatchBox Hackathon, please DM me on Twitter [@itsonlysoleil](https://twitter.com/itsonlysoleil), by July 1st._

#### **Early Implementation Details**
 
The game would be designed by encrypting every 5 words with 5 private keys, and have the frontend abstract all of that away. Basically if you upgrade your skill tree enough, you add an RLN to your opponent's chat, which up to this point you can think of as PGP or AES encrypted, with their keys created via [Diffie-Hellman](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) (or an equivalent) key exchange at the start of the round, and stored on their local game client or frontend. As your skill tree advances you get access to every other word in their chat, or every 2/5 words, or eventually 5/5, and this adds a degree of counterplay to asymmetric information communication games like Mafia or Diplomacy.

The longterm vision of this project will be to create a minimum viable product standard that is easy to compose on. This project also introduces new game theoretic play where the longer the gameplay goes on for (in theory), your opponent players will become more covered in how they internally communicate because the possibility that someone has access to chat words goes up. This can be balanced by a higher (or quadratic) cost to unlocking the last 'pareto' distributed scope over opponent's speech, so as to make it a point tradeoff to spec into these components completely.

Although a lot of hashing primitives written in Cairo and on Starkware are under development, I believe there's enough open source material to build a proof of concept. If all else, we can use our efforts as an oppurtunity to define implementations for the standards that would make this core feature for many games possible, and widen what is possible in the Cairo ecosystem in the future.

#### **Asymetric Information Games to Playtest/Extend**

- [Town of Salem](https://www.blankmediagames.com/) Basically Mafia/Werewolf the party game online
- [Backstabbr](https://www.backstabbr.com/) Diplomacy Online w/ good sandboxes to iterate on turn-based communication point. 

MatchboxDAO's hackathon invites devs working on new gaming primitives to experiment with Cairo. 

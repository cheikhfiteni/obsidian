## Roadmap Page

### **Rough Architecture Notes**

Frontend/Client/Contract schematics can be summarized here:

![Flowcharts](https://user-images.githubusercontent.com/20891428/177453892-b7c42ba4-6972-414c-9327-5e7348399ac5.jpeg)



#### Resources (ADD as you find relevant material on; numbered are topic areas where more shared knowledge is needed)

1. Frontend library for interacting with Cairo contracts or wallet extensions from a React hooks interface. Think ethers.js or wagmi lib equivalent
    - [Starknet React Hooks](https://github.com/apibara/starknet-react) Starknet equivalent of Wagmi custom hooks
2. More resources on understanding how Rate Limiter Nullifiers work, and lean implementations in solidity we can adapt for word by word en/decryption.
    - [Vitalik post mentioning concept](https://vitalik.ca/general/2022/06/15/using_snarks.html)
    - [High level Medium post by team](https://medium.com/privacy-scaling-explorations/rate-limiting-nullifier-a-spam-protection-mechanism-for-anonymous-environments-bbe4006a57d)
    - [Spec implementation in a p2p protocol](https://rfc.vac.dev/spec/32/)
    - [Semaphore solidity implementation](https://ethresear.ch/t/semaphore-rln-rate-limiting-nullifier-for-spam-prevention-in-anonymous-p2p-setting/5009) with [Github repo](https://github.com/semaphore-protocol/semaphore)
    - TODO cut all these down and read myself (@cheikhfiteni) to know what is good.
3. Cairo specific contract primitives that make sense in context of current [schematic](TODO have this link to a file/image in repo with transferred architecture schematic)
    - Use a modified [Account](https://github.com/OpenZeppelin/cairo-contracts/blob/main/docs/Account.md) contract to post and read from state. SDK will call from here
    - Need there to be a round registry contract. Will these use storage vars?
    - 
4. What are cheap, easy Github Actions we can add to enforce style/do testing checks to make CI/CD dev easiest in this week? Lowest priority, but if there is a way to be faster shipping and you can make a case, drop it.

Less important but useful for understanding how project works:
- [Diffie-Helman Key exchange explained](https://www.youtube.com/watch?v=YEBfamv-_do)
- [Town of Salem Classic Playthrough](https://www.youtube.com/watch?v=Zjg5jCWoKN0)

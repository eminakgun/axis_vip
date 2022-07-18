# AXI Stream Verification IP
This repo contains an UVM based AXI Stream VIP

## Diagram
![Diagram](doc/vip-architecture.png)

## Features
- [ ] Assertion based property checking
- [x] AXI4-Stream Pin Interface
- [x] Standalone Bus Functional Models (independent of UVM based components)
  - [x] Master BFM 
  - [x] Slave BFM
  - [x] Monitor BFM
- [x] UVM Agent
  - [x] Configuration
  - [x] Driver
  - [x] Monitor
  - [x] Sequencer
  - [ ] Coverage collection
- [x] UVM Sequence Item
- [ ] UVM Sequences
  - [x] Default full random sequence 
  - [ ] Byte stream sequence
  - [ ] Continous aligned stream sequence
  - [ ] Continous unaligned stream sequence
  - [ ] Sparse stream sequence
- [ ] UVM Environment
  - [ ] Environment Configuration
  - [ ] Virtual sequencer
  - [x] Scoreboard
  - [ ] Coverage collection 

## TODO
  - [x] Transfer based simulation
  - [ ] Packet based simulation
  - [x] Add Scoreboard
  - [x] Add agent covergroups
  - [x] Add match/mismatch count in scoreboard
  - [ ] Add SVAs
  - [ ] Add default value signaling
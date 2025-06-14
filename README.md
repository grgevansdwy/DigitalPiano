# ARM64 Pipelined CPU

This project implements a 64-bit ARM pipelined CPU using SystemVerilog. It includes features such as:

- 5-stage pipeline: IF, ID, EX, MEM, WB
- Data forwarding and hazard handling
- Support for various ARM instructions and delay slots
- Simulation using waveform `.do` scripts and ARM test programs

## Files

- `.sv` – SystemVerilog modules
- `.arm` – Test programs
- `.do` – ModelSim waveform scripts

## Run Instructions

1. Open in ModelSim or another Verilog simulator.
2. Load the appropriate `.do` waveform and `.arm` test file.
3. Compile and simulate to verify correct behavior.

## 📚 References

- [ARM Architecture Reference Manual]
- Course textbook on Computer Organization and Design
- Instructor and TA lecture notes

## Credits

Developed as part of a Computer Architecture course project.

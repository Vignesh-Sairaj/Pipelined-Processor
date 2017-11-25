# Pipelined-Processor

A fully pipelined MIPS-inspired 32-bit processor with branch detection and forwarding. Supports 32-bit IEEE-754 floating point instructions.


- To run the simulation, compile and run the file PipelinedProcessor_tb.v using iVerilog.

- The opCodes and the operations supported are specified in the file InstructionSet.txt
- A sample program is stored in Instruction Memory module that generates numbers in the Fibonacci sequence.

- The primary pipeline is a 5-stage MIPS-style pipeline in the top level.
- The clock is divided into 6 sub-cycles which is used for the other modules.


- Modules Used: ALU, FPU, DataMemory, Instruction Memory
- Each module has a number of submodules in its own folder. 

- The FPU adder/subtracter unit requires 5 clock cycles and the multiplier requires 4 cycles.
- All adders and multipliers use carry lookahead adders and Wallace tree multipliers.
- Python code-generating scripts provided for carry lookahead adder (CLA), Barrel left/right shifter, prefix adder and partial product generator (for WTree Multiplier).
	
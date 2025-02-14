`timescale 1ns / 1ps
module ControlUnit_sim();

  // Input signals
  reg [5:0] OpCode;
  reg [5:0] func;
  reg zero;
  reg sign;

  // Output signals
  wire PCWire, ALUSrcA, ALUSrcB, DBDataSrc, RegWire, InsMemRW, RD, WR, RegDst, ExtSel;
  wire [1:0] PCSrc;
  wire [2:0] ALUOp;

  // Instantiate the Unit Under Test (UUT)
  ControlUnit uut (
    .OpCode(OpCode),
    .func(func),
    .zero(zero),
    .sign(sign),
    .PCWire(PCWire),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .DBDataSrc(DBDataSrc),
    .RegWire(RegWire),
    .InsMemRW(InsMemRW),
    .RD(RD),
    .WR(WR),
    .RegDst(RegDst),
    .ExtSel(ExtSel),
    .PCSrc(PCSrc),
    .ALUOp(ALUOp)
  );

  // Testbench
  initial begin
    // Record waveforms
    $dumpfile("ControlUnit16.vcd");
    $dumpvars(0, ControlUnit_sim);

    // Initialize signals
    zero = 1'b0;
    sign = 1'b0;

    // Test Case 1: ADD (R-type)
    OpCode = 6'b000000;
    func = 6'b100000;  // ADD
    #50;
    
    OpCode = 6'b000000;
    func = 6'b100010;  // SUB
    #50;
    
    OpCode = 6'b001001;
    func = 6'bxxxxxx;  // ADDIU
    #50;
    
    OpCode = 6'b001100;
    func = 6'bxxxxxx;  // ANDI
    #50;
    
    OpCode = 6'b000000;
    func = 6'b100100;  // AND
    #50;
    
    OpCode = 6'b001101;
    func = 6'bxxxxxx;  // ORI
    #50;
  
    OpCode = 6'b000000;
    func = 6'b100101;  // OR
    #50;
    
    OpCode = 6'b000000;
    func = 6'b000000;  // SLL
    #50;    

    OpCode = 6'b001010;
    func = 6'bxxxxxx;  // SLTI
    #50;
    
    OpCode = 6'b101011;
    func = 6'bxxxxxx;  // SW
    #50;
    
    OpCode = 6'b100011;
    func = 6'bxxxxxx;  // LW
    #50;
    
    OpCode = 6'b000100;
    func = 6'bxxxxxx;  // BEQ
    zero = 1'b1;
    #50;
    
    OpCode = 6'b000101;
    func = 6'bxxxxxx;  // BNE
    zero = 1'b0;
    #50;
    
    OpCode = 6'b000110;
    func = 6'bxxxxxx;  // BLEZ
    sign = 1'b1;
    #50;
    
    OpCode = 6'b000010;
    func = 6'bxxxxxx;  // J
    #50;
    
    OpCode = 6'b111111;
    func = 6'bxxxxxx;  // HALT
    #50;
    $stop;
    end
    endmodule
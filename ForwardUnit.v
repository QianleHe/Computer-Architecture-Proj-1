`include "config.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name:    ForwardUnit
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ForwardUnit(
		//input[4:0] rs,
		//input[4:0] rt,
		input[4:0] EX_MEMrd, 
		input[4:0] MEM_WBrd,
		input[4:0] ID_EXrs,
		input[4:0] ID_EXrt,
		input RegWrite_EXMEM,
		input RegWrite_MEMWB,
		output reg [1:0] ForwardA,
		output reg [1:0] ForwardB
	);


//EX hazard:

//if(EX/MEM.RegWrite 
//and(EX/MEM.RegisterRd != 0) 
//and(EX/MEM.RegisterRd == ID/EX.RegisterRs))ForwardA = 10
//if(EX/MEM.RegWrite 
//and(EX/MEM.RegisterRd != 0) 
//and(EX/MEM.RegisterRd == ID/EX.RegisterRt))ForwardB = 10

//MEM hazard:

//if(MEM/WB.RegWrite 
//and(MEM/WB.RegisterRd != 0) 
//and(EX/MEM.RegisterRd != ID/EX.RegisterRs) 
//and(MEM/WB.RegisterRd == ID/EX.RegisterRs))ForwardA = 01
//if(MEM/WB.RegWrite 
//and(MEM/WB.RegisterRd != 0) 
//and(EX/MEM.RegisterRd != ID/EX.RegisterRt) 
//and(MEM/WB.RegisterRd == ID/EX.RegisterRt))ForwardB = 01

// start judgement
always @(*)
	begin
		// EX hazard
		if ((RegWrite_EXMEM) && (EX_MEMrd != 0) && (EX_MEMrd == ID_EXrs))
			ForwardA = 2'b10;
		else
		if ((RegWrite_MEMWB) && (MEM_WBrd != 0) && (EX_MEMrd != ID_EXrs) && (MEM_WBrd == ID_EXrs))
			ForwardA = 2'b01;
		else
			ForwardA = 2'b00;

		if ((RegWrite_EXMEM) && (EX_MEMrd != 0) && (EX_MEMrd == ID_EXrt))
			ForwardB = 2'b10;
		else
		if ((RegWrite_MEMWB) && (MEM_WBrd != 0) && (EX_MEMrd != ID_EXrt) && (MEM_WBrd == ID_EXrt))
			ForwardB = 2'b01;
		else 
			ForwardB = 2'b00;
	end






endmodule
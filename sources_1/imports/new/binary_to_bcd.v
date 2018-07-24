`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2018 13:39:07
// Design Name: 
// Module Name: binary_to_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module binary_to_bcd(
    input      [15:0] bin,
    output reg [15:0] bcd
    );
    
    reg [15:0] bcd_data = 0;
    
    always @(bin)
    begin
        bcd_data   = bin;
        bcd[15:12] = bcd_data / 1000;
        bcd_data   = bcd_data % 1000;
        
        bcd[11:8]  = bcd_data / 100;
        bcd_data   = bcd_data % 100;
        
        bcd[7:4]   = bcd_data / 10;
        bcd[3:0]   = bcd_data % 10;
    end
    
endmodule

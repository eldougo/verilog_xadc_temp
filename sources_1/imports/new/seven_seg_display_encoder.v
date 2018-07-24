`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2018 14:42:43
// Design Name: 
// Module Name: seven_seg_display_encoder
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


module seven_seg_display_encoder(
    input [3:0] in,
    output [6:0] out
    );
    
    function [6:0] encode7seg;
        input [3:0] hex_digit;
        begin
            case (hex_digit)
                4'h0 : encode7seg = 7'h3F;
                4'h1 : encode7seg = 7'h06;
                4'h2 : encode7seg = 7'h5B;
                4'h3 : encode7seg = 7'h4F;
                4'h4 : encode7seg = 7'h66;
                4'h5 : encode7seg = 7'h6D;
                4'h6 : encode7seg = 7'h7D;
                4'h7 : encode7seg = 7'h07;
                4'h8 : encode7seg = 7'h7F;
                4'h9 : encode7seg = 7'h6F;
                4'ha : encode7seg = 7'h77;
                4'hb : encode7seg = 7'h7C;
                4'hc : encode7seg = 7'h39;
                4'hd : encode7seg = 7'h5E;
                4'he : encode7seg = 7'h79;
                4'hf : encode7seg = 7'h71;
            endcase
        end
    endfunction
    
    assign out = encode7seg( in );
    
endmodule

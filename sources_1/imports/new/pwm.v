`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2018 13:53:01
// Design Name: 
// Module Name: pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Convert the input level to PWM proportional output.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input clk,
    input [3:0] i_lvl,
    output o_pwm
    );
    
    reg [7:0] r_pwm_cntr = 0;
    reg       r_pwm_out  = 0;
    
    always @(posedge clk)
    begin
        r_pwm_cntr = r_pwm_cntr + 1;
        
        // In case the requested level is zero, make it like really really dim 
        // instead of just just dim. 
        if ( i_lvl == 0 )
            r_pwm_out  = ( r_pwm_cntr < 8'h02 );
        else
            r_pwm_out  = ( r_pwm_cntr[7:4] <= i_lvl); 
    end
    
    assign o_pwm = r_pwm_out;
    
endmodule

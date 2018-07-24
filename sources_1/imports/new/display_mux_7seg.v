`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2018 09:51:48
// Design Name: 7 Segment display multiplexer
// Module Name: display_mux_7seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Encode and multiplex the four digit input buffer to display on a seven segment display.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define CNTR_BITS 21

module display_mux_7seg
   #(parameter g_COUNTER_STEP = 1)
    (input clk,
    input [15:0] display_buffer,
    output [3:0] o_anodes,
    output [6:0] o_cathodes
    );
    
    reg  [`CNTR_BITS-1:0] r_refresh_cntr = 0;   // Clock divider used to refresh the display
    wire [3:0]  w_display_digit;                // Encoded digit to display
    wire [3:0]  w_active_anode;                 // Current active display
    wire [6:0]  w_active_cathodes;
    wire [1:0]  w_display_counter;
    
    // CLock divider
    always @(posedge clk)
        r_refresh_cntr = r_refresh_cntr + g_COUNTER_STEP;
    
    // Select the buffered digit to display
    function [3:0] get_display_digit;
        input [15:0] in_buf;
        input [1:0]  selector;
        case (selector)
            2'b11: get_display_digit = in_buf[15:12];
            2'b10: get_display_digit = in_buf[11:8];
            2'b01: get_display_digit = in_buf[7:4];
            2'b00: get_display_digit = in_buf[3:0];
        endcase
    endfunction
    
    // The active display is the top two bits of the main refresh counter.
    assign w_display_counter = r_refresh_cntr[`CNTR_BITS-1:`CNTR_BITS-2];
    
    // Decode which display is active
    two_to_four_decoder decode_anode(.out(w_active_anode), .in(w_display_counter));
    
    // Select the active digit from the buffer to display.
    assign w_display_digit = get_display_digit( .in_buf(display_buffer), .selector(w_display_counter) );
    
    // Encode the digit to be displayed into 7 segment representation
    seven_seg_display_encoder encode_digit(.out(w_active_cathodes), .in(w_display_digit));
    
    // Set the outputs
    assign o_anodes   = w_active_anode;
    assign o_cathodes = w_active_cathodes;
    
endmodule

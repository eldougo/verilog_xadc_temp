`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2018 12:29:20
// Design Name: 
// Module Name: xadc_temperature
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


module xadc_temperature(
    input clk,
    output reg [15:0] led,
    output [3:0] an,
    output [6:0] seg
    );
    
    wire enable;
    wire ready;
    wire [15:0] data;
    reg  [11:0] temper;
    wire [15:0] display_buffer;
    wire [3:0]  w_anodes;
    wire [6:0]  w_cathodes;
    reg [27:0]  r_1_second_counter;          // One second timer counter
    reg r_1_second_pulse;                   // Goes high for one clock cycle every second
    
    parameter c_CYCLES_PER_SECOND = 28'd100000000;
    
    xadc_wiz_0 xlxi_7 (
      .daddr_in(7'h00),                        // input wire [6 : 0] daddr_in
      .dclk_in(clk),                          // input wire dclk_in
      .den_in(enable),
      .do_out(data),
      .eoc_out(enable),
      .drdy_out(ready)
    );
    
    binary_to_bcd binary_to_bcd(.bin(temper), .bcd(display_buffer));
    
    display_mux_7seg display_mux_7seg(.clk(clk), .display_buffer(display_buffer), .o_anodes(w_anodes), .o_cathodes(w_cathodes));
    
    assign an  = ~w_anodes;
    assign seg = ~w_cathodes;
    
    /*
    always @(posedge clk)
    begin
        if (ready == 1'b1)
        begin
            led    <= data;
            temper <= ((data[15:4] * 504) / 4096) - 273;
        end
    end
    */
    
    // Generate a pulse every second
    always @(posedge clk)
    begin
        r_1_second_counter = r_1_second_counter + 1'b1;
        if (r_1_second_counter >= c_CYCLES_PER_SECOND)
        begin
            r_1_second_counter <= 0;
            r_1_second_pulse   <= 1'b1;
            led                <= data;
            temper             <= ((data[15:4] * 504) / 4096) - 273;
        end
        else
            r_1_second_pulse <= 1'b0;
    end
    
endmodule

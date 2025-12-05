// =================================================================
// Module: seven_segment_driver (LOGICAL, UN-SCRAMBLED VERSION)
// =================================================================
module seven_segment_driver(
    input clk,
    input rst,
    input [15:0] digits_in,
    output reg [6:0] seg,
    output reg [3:0] an
);
    // ... (multiplexing logic remains the same) ...
    reg [15:0] prescaler = 0;
    wire refresh_tick;
    assign refresh_tick = (prescaler == 16'd65535);

    always @(posedge clk or posedge rst) begin
        if (rst) prescaler <= 0;
        else if (refresh_tick) prescaler <= 0;
        else prescaler <= prescaler + 1;
    end

    reg [1:0] an_select = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) an_select <= 0;
        else if (refresh_tick) an_select <= an_select + 1;
    end
    
    wire [3:0] current_digit;
    assign current_digit = (an_select == 2'b00) ? digits_in[3:0]   :
                         (an_select == 2'b01) ? digits_in[7:4]   :
                         (an_select == 2'b10) ? digits_in[11:8]  :
                                                digits_in[15:12];

    always @(*) begin
        case (an_select)
            2'b00:   an = 4'b1110;
            2'b01:   an = 4'b1101;
            2'b10:   an = 4'b1011;
            2'b11:   an = 4'b0111;
            default: an = 4'b1111;
        endcase

        // --- THIS IS THE CORRECT, LOGICAL MAPPING ---
        case (current_digit)
            4'd0: seg = 7'b1000000; // 0
            4'd1: seg = 7'b1111001; // 1
            4'd2: seg = 7'b0100100; // 2
            4'd3: seg = 7'b0110000; // 3
            4'd4: seg = 7'b0011001; // 4
            4'd5: seg = 7'b0010010; // 5
            4'd6: seg = 7'b0000010; // 6
            4'd7: seg = 7'b1111000; // 7
            4'd8: seg = 7'b0000000; // 8
            4'd9: seg = 7'b0010000; // 9
            default: seg = 7'b1111111; // Off
        endcase
    end
endmodule
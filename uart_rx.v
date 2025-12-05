// =================================================================
// Module: uart_rx
// Description: Receives serial data (8-N-1 format).
// =================================================================
module uart_rx #(
    parameter CLK_FREQ = 100000000, // Basys3 clock frequency (100 MHz)
    parameter BAUD_RATE = 9600     // Must match Python script
)(
    input clk,
    input rst,
    input rx,                      // Serial data input
    output reg [7:0] data,         // Received byte
    output reg valid              // High for one clock cycle when data is ready
);

    localparam integer BAUD_TICK = CLK_FREQ / BAUD_RATE;
    localparam integer HALF_BAUD = BAUD_TICK / 2;

    reg [15:0] baud_cnt = 0;
    reg [3:0] bit_index = 0;
    reg [9:0] shift_reg = 0;
    reg busy = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            baud_cnt <= 0;
            bit_index <= 0;
            busy <= 0;
            valid <= 0;
            data <= 0;
        end else begin
            valid <= 0; // Default to low

            if (!busy) begin
                if (!rx) begin // Wait for start bit (rx goes low)
                    busy <= 1;
                    baud_cnt <= HALF_BAUD;
                    bit_index <= 0;
                end
            end else begin
                if (baud_cnt == BAUD_TICK - 1) begin
                    baud_cnt <= 0;
                    shift_reg <= {rx, shift_reg[9:1]};
                    bit_index <= bit_index + 1;

                    if (bit_index == 9) begin // All 10 bits received
                        busy <= 0;
                        if (shift_reg[0] == 1'b1 && shift_reg[9] == 1'b0) begin
                           data <= shift_reg[8:1];
                           valid <= 1;
                        end
                    end
                end else begin
                    baud_cnt <= baud_cnt + 1;
                end
            end
        end
    end
endmodule
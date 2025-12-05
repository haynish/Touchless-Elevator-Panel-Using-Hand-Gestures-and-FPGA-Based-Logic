// =================================================================
// Module: gesture_elevator_top (UPDATED FOR 4-DIGIT HISTORY)
// =================================================================
module gesture_elevator_top(
    input clk,
    input rst,
    input rx,
    output [6:0] seg,
    output [3:0] an
);

    wire [7:0] rx_data;
    wire rx_valid;

    // A 16-bit shift register to store the last four 4-bit floor numbers
    reg [15:0] floor_history = 16'hFFFF; // Start with display off

    // Instantiate the UART Receiver
    uart_rx uart_receiver (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data(rx_data),
        .valid(rx_valid)
    );
    
    // --- THIS IS THE CORRECT INSTANTIATION ---
    // It connects to 'clk', 'rst', and the correct port name 'digits_in'
    seven_segment_driver display_driver (
        .clk(clk),
        .rst(rst),
        .digits_in(floor_history),
        .seg(seg),
        .an(an)
    );

    // When a new valid byte arrives, shift the history and add the new number
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            floor_history <= 16'hFFFF;
        end else if (rx_valid) begin
            // Shift old digits left, place new digit on the right
            floor_history <= {floor_history[11:0], rx_data[3:0]};
        end
    end
    
endmodule
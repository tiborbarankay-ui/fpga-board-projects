module uart_demo_top (
    input  wire       FPGA_CLK1_50,
    output wire [7:0] LED,
    output wire       UART_TX
);
    wire clk = FPGA_CLK1_50;
    localparam MSG_LEN = 14;

    function [7:0] msg_char(input [3:0] i);
        case (i)
            0: msg_char = "H";  1: msg_char = "e";  2: msg_char = "l";
            3: msg_char = "l";  4: msg_char = "o";  5: msg_char = ",";
            6: msg_char = " ";  7: msg_char = "D";  8: msg_char = "E";
            9: msg_char = "1"; 10: msg_char = "0"; 11: msg_char = "!";
            12: msg_char = 8'h0D; 13: msg_char = 8'h0A;
            default: msg_char = 8'h20;
        endcase
    endfunction

    reg [25:0] gap_cnt   = 0;
    reg [3:0]  idx       = 0;
    reg        sending   = 0;
    reg        tx_start  = 0;
    reg [7:0]  tx_data   = 0;
    reg [7:0]  msg_count = 0;
    wire       tx_done, tx_line;

    always @(posedge clk) begin
        tx_start <= 1'b0;
        if (!sending) begin
            gap_cnt <= gap_cnt + 1'b1;
            if (&gap_cnt) begin
                sending  <= 1'b1;
                idx      <= 0;
                tx_data  <= msg_char(4'd0);
                tx_start <= 1'b1;
            end
        end else if (tx_done) begin
            if (idx == MSG_LEN - 1) begin
                sending   <= 1'b0;
                msg_count <= msg_count + 1'b1;
            end else begin
                idx      <= idx + 1'b1;
                tx_data  <= msg_char(idx + 1'b1);
                tx_start <= 1'b1;
            end
        end
    end

    uart_tx #(.CLKS_PER_BIT(434)) u_tx (
        .clk(clk), .tx_start(tx_start), .tx_data(tx_data),
        .tx_line(tx_line), .tx_done(tx_done)
    );

    assign UART_TX = tx_line;
    assign LED     = msg_count;
endmodule

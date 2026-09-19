/*
 * Copyright (c) 2024 Your Name
 * SP-DX license identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered or selected
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Khai báo biến đếm 8-bit
  reg [7:0] count;

  // Gán giá trị đếm ra các chân Output chính
  assign uo_out = count;

  // Không dùng các chân bidirectional IOs -> Đặt về 0
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // Loại bỏ cảnh báo linter cho các tín hiệu không dùng
  wire _unused = &{ena, ui_in, uio_in, 1'b0};

  // Logic bộ đếm
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count <= 8'b0;
    end else begin
      count <= count + 1'b1;
    end
  end

endmodule

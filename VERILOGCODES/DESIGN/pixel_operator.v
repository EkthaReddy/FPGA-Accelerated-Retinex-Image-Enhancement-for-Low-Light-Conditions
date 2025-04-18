`timescale 1ns / 1ps

module pixel_operator(
    input wire [11:0] pixel_in,
    input wire [1:0] Pixel_sel,
    input wire clock,
    output reg [11:0] Out_pixel
);

wire [11:0] Contrast_value = 12'b101010101010;
wire [11:0] Pixel_value = 12'b101010101010;

always @(posedge clock) begin
    case(Pixel_sel)
        2'b00: Out_pixel <= pixel_in;
        2'b01: Out_pixel <= (pixel_in < Pixel_value) ? 12'b000000000000 : (pixel_in - Pixel_value);
        2'b10: Out_pixel <= (pixel_in > Contrast_value) ? 12'b111111111111 : 12'b000000000000;
        2'b11: Out_pixel <= 12'b111111111111 - pixel_in;
        default: Out_pixel <= pixel_in; // Default case for safety
    endcase
end

endmodule
`timescale 1ns / 1ps

module controler(
    input         clk,
    input         rst,
    output [16:0] address,
    input  [11:0] data,
    output  [3:0] vgaRed,
    output  [3:0] vgaBlue,
    output  [3:0] vgaGreen,
    output        hsync,
    output        vsync
);    
    localparam [9:0] WIDTH  = 640;
    localparam [9:0] HEIGHT = 480;
    
    localparam [9:0] BEGINNING_OF_HORIZONTAL_SYNC   = 16;
    localparam [9:0] END_OF_HORIZONTAL_SYNC         = BEGINNING_OF_HORIZONTAL_SYNC  + 96;
    localparam [9:0] BEGINNING_OF_DISPLAY_PIXELS_H  = END_OF_HORIZONTAL_SYNC        + 48;
    localparam [9:0] END_OF_ROW                     = BEGINNING_OF_DISPLAY_PIXELS_H + WIDTH;

    localparam [9:0] BEGINNING_OF_VERTICAL_SYNC     = 10;
    localparam [9:0] END_OF_VERTICAL_SYNC           = BEGINNING_OF_VERTICAL_SYNC    + 2;
    localparam [9:0] BEGINNING_OF_DISPLAY_PIXELS_V  = END_OF_VERTICAL_SYNC          + 33;
    localparam [9:0] END_OF_COLUMN                  = BEGINNING_OF_DISPLAY_PIXELS_V + HEIGHT;

    reg [9:0] h_count;
    always@(posedge clk)
    begin
        if (rst)
            h_count <= 0;
        else
            h_count <= (h_count == END_OF_ROW - 1) ? 0 : h_count + 1;
    end

    reg [9:0] v_count;
    always@(posedge clk)
    begin
        if (rst)
            v_count <= 0;
        else if (h_count == END_OF_ROW - 1)
            v_count <= (v_count == END_OF_COLUMN - 1) ? 0 : v_count + 1;
    end
    
    reg [16:0] base_address;
    always@(posedge clk)
    begin
        if (rst)
            base_address <= 0;
        else
            if (v_count < BEGINNING_OF_DISPLAY_PIXELS_V)
                base_address <= 0;
            else if ((h_count == END_OF_ROW - 1) & (v_count[0] == 0))
                base_address <= base_address + WIDTH / 2;
    end

    reg [16:0] offset;
    always@(posedge clk)
    begin
        if (rst)
            offset <= 0;
        else
            if (h_count < BEGINNING_OF_DISPLAY_PIXELS_H)
                offset <= 0;
            else if (h_count[0] == 1)
                offset <= offset + 1;
    end

    assign address = base_address + offset;
    assign {vgaRed, vgaBlue, vgaGreen} = data;    

    assign hsync = ~((BEGINNING_OF_HORIZONTAL_SYNC <= h_count) & (h_count < END_OF_HORIZONTAL_SYNC));
    assign vsync = ~((BEGINNING_OF_VERTICAL_SYNC   <= v_count) & (v_count < END_OF_VERTICAL_SYNC));
endmodule




//VGA2_FEB18
`timescale 1ns / 1ps

module multiplier #(parameter data_width = 4)
               (input [data_width-1:0] A,
               input [data_width-1:0] B,
               output [2*data_width-1:0] product);
               
               
wire [2:0] col_inv_bits, row_inv_bits;

assign col_inv_bits[0] = ~(B[0] & A[3]);
assign col_inv_bits[1] = ~(B[1] & A[3]);
assign col_inv_bits[2] = ~(B[2] & A[3]);

assign row_inv_bits[0] = ~(B[3] & A[0]);
assign row_inv_bits[1] = ~(B[3] & A[1]);
assign row_inv_bits[2] = ~(B[3] & A[2]);

assign product[0] = A[0] & B[0];


endmodule

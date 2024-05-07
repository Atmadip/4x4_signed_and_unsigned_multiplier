`timescale 1ns / 1ps

module multiplier #(parameter data_width = 4)
               (input [data_width-1:0] A,
               input [data_width-1:0] B,
               output [(2*data_width)-1:0] product);
               
               
wire [2:0] col_inv_bits, row_inv_bits;
wire [2:0] partial_product[2:0];
wire a3b3;
wire [11:0] sum;
wire [11:0] carry;


assign partial_product[0][0] = A[0] & B[0];
assign partial_product[0][1] = A[1] & B[0]; 
assign partial_product[0][2] = A[2] & B[0];  

assign partial_product[1][0] = A[0] & B[1];
assign partial_product[1][1] = A[1] & B[1]; 
assign partial_product[1][2] = A[2] & B[1];

assign partial_product[2][0] = A[0] & B[2];
assign partial_product[2][1] = A[1] & B[2]; 
assign partial_product[2][2] = A[2] & B[2];  
  


assign col_inv_bits[0] = ~(B[0] & A[3]);
assign col_inv_bits[1] = ~(B[1] & A[3]);
assign col_inv_bits[2] = ~(B[2] & A[3]);

assign row_inv_bits[0] = ~(B[3] & A[0]);
assign row_inv_bits[1] = ~(B[3] & A[1]);
assign row_inv_bits[2] = ~(B[3] & A[2]);

assign a3b3 = A[3] & B[3];

//coloumn 2
half_adder h0(partial_product[0][1], partial_product[1][0], carry[0], sum[0]);

//coloumn 3
full_adder fa0(carry[0], partial_product[0][2], partial_product[1][1], carry[1], sum[1]);
half_adder h1(sum[1], partial_product[2][0], carry[2], sum[2]);

// coloumn 4
full_adder fa1(col_inv_bits[0], partial_product[1][2], carry[1], carry[3], sum[3]);
full_adder fa2(partial_product[2][1], row_inv_bits[0], carry[2], carry[4], sum[4]);
half_adder h2(sum[3], sum[4], carry[5], sum[5]);

//coloumn 5
full_adder fa3(col_inv_bits[1], partial_product[2][2], carry[3], carry[6], sum[6]);
full_adder fa4(row_inv_bits[1], 1'b 1, carry[4], carry[7], sum[7]);
full_adder fa5(sum[6], sum[7], carry[5], carry[8], sum[8]);

//coloumn 6
full_adder fa6(col_inv_bits[2], row_inv_bits[2], carry[6], carry[9], sum[9]);
full_adder fa7(sum[9], carry[7], carry[8], carry[10], sum[10]);

//coloumn 7
full_adder fa8(carry[9], a3b3, carry[10], carry[11], sum[11]);

//coloumn 8
 
assign product[0] = partial_product[0][0];
assign product[1] = sum[0];
assign product[2] = sum[2];
assign product[3] = sum[5];
assign product[4] = sum[8];
assign product[5] = sum[10];
assign product[6] = sum[11];
assign product[7] = ~carry[11];



endmodule

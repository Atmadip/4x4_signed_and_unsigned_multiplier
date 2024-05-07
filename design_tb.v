`timescale 1ns / 1ps

module design_tb #(parameter data_width = 4);
          reg [data_width-1:0] A;
          reg [data_width-1:0] B;
          wire [(2*data_width)-1:0] product;
          
          
          multiplier UUT(A, B, product);
          
          initial begin
          
          A = 4'b 1000;
          B = 4'b 1111;
          #100;
          
          A = 4'b 1111;
          B = 4'b 1111;
          #100;
          
          A = 4'b 1001;
          B = 4'b 0011;
          #100;
          
          A = 4'b 0011;
          B = 4'b 0101;
          #100;
          
          $finish;
          end


endmodule

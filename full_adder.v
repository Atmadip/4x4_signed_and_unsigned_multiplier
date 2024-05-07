`timescale 1ns / 1ps

module full_adder(a, b, cin, cout, sum);

input a, b, cin;
output sum, cout;

    assign sum = a^b^cin;
    assign cout = (a&b) | (cin & (a^b));
    
endmodule

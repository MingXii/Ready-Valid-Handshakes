//----------------------------------------------------------------------------------------
// File name:           slave
// Last modified Date:  2021/12/11 12:29
// Last Version:        V1.0
// Descriptions:        从机，
//                      
//----------------------------------------------------------------------------------------
// Created by:          SJ
// Created date:        2021/12/11 12:29
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
module slave#( parameter WIDTH = 8)(
	input clk,
	input rst_n,
	input en,
	input s_valid,
	input [WIDTH-1:0] s_data_in,
	output reg s_ready,
	output reg [WIDTH-1:0] s_data_out
);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			s_ready <= 1'b0;
		end
		else begin
			s_ready <= en;
		end
	end

    always@ (posedge clk or negedge rst_n) begin
        if (!rst_n)
            s_data_out <= {WIDTH{1'b0}};                 
        else if (s_ready && s_valid)
            s_data_out <= s_data_in;              
        else 
            s_data_out <= {WIDTH{1'b1}};
    end      

endmodule
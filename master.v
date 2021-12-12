//----------------------------------------------------------------------------------------
// File name:           master
// Last modified Date:  2021/12/11 12:29
// Last Version:        V1.0
// Descriptions:        主机，当数据使能EN拉高时，主机便发送数据。
//                      
//----------------------------------------------------------------------------------------
// Created by:          SJ
// Created date:        2021/12/11 12:29
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
module master#( parameter WIDTH = 8)(
	input clk,
	input rst_n,
	input en,
	input m_ready,
	output reg [WIDTH-1:0] m_data,
	output reg m_valid
);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_data <= {WIDTH{1'b0}};
		end
		else if (m_valid&m_ready) begin
			m_data <= m_data + 1'b1;
		end
		else begin
			m_data <= m_data;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_valid <= 1'b0;
		end
		else begin
			m_valid <= en;
		end
	end


endmodule
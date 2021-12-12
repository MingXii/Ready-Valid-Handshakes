`timescale 1ns / 1ps
module handshake_tb ();

	parameter WIDTH = 8;

	reg clk;
	reg rst_n;
	reg m_en;
	reg m_en_d;
	reg s_en;
	reg s_en_d;
	wire [WIDTH-1:0] data_out;

	initial begin
		clk = 1'b1;
		while (1)
		#5 clk = ~clk;	
	end

	initial begin
		rst_n = 1'b1;
		#10 rst_n = 1'b0;
		#50 rst_n = 1'b1;
	end

	initial begin
		m_en = 1'b0;
		#100 m_en = 1'b1;
		#100 m_en = 1'b0;//200
		#10	 m_en = 1'b1;//210
		#20	 m_en = 1'b0;//230
		#100 $stop;
	end

	initial begin
		s_en = 1'b0;
		#50 s_en = 1'b1;
		#100 s_en = 1'b0;//150
		#10	 s_en = 1'b1;//160
		#20	 s_en = 1'b0;//180
		#20  s_en = 1'b1;
		#40  s_en = 1'b0;
	end

	always @(posedge clk) begin
		m_en_d <= m_en;
		s_en_d <= s_en;
	end
	handshake_top inst_handshake_top (.clk(clk), .rst_n(rst_n), .m_en(m_en_d), .s_en(s_en_d), .data_out(data_out));
endmodule
//----------------------------------------------------------------------------------------
// File name:           Backward_Registered 
// Last modified Date:  2021/12/11 12:29
// Last Version:        V1.0
// Descriptions:        顶层文件
//                      
//----------------------------------------------------------------------------------------
// Created by:          SJ
// Created date:        2021/12/11 12:29
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
module Backward_Registered #( parameter WIDTH = 8)(
	input clk,
	input rst_n,
	input m_valid,
	input [WIDTH-1:0] m_data,
	output m_ready,
	output s_valid,
	output [WIDTH-1:0] s_data,
	input s_ready
	);
		
	reg s_ready_d;
	reg m_valid_d;
	reg [WIDTH-1:0] m_data_d;
	wire s_ready_dge;
	reg valid_skid;
	reg [WIDTH-1:0] data_skid;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			s_ready_d <= 1'd0;
		end
		else begin
			s_ready_d <= s_ready;
		end
	end

	always @(posedge clk or negedge rst_n) begin
	 	if (!rst_n)
	 	  	m_valid_d <= 1'b0;          
	 	else if (m_ready)
	 	  	m_valid_d <= m_valid;         
	 	end                                                       

	always @(posedge clk or negedge rst_n) begin
	  	if (!rst_n)
	  	  	m_data_d <= {WIDTH{1'b0}};          
	  	else if (m_ready)
	  	  	m_data_d <= m_data;         
	end                                    
	

	always @(posedge clk or negedge rst_n) begin
	  	if (!rst_n)
	  	  	valid_skid <= 1'b0;          
	  	else if (valid_skid)
	  	 	valid_skid <= ~s_ready;          
	  	else if (s_ready_dge)
	  	  	valid_skid <= m_valid;    //buffer_skid中有数据有效信号
	end                           
	  
	
	always @(posedge clk or negedge rst_n) begin
	  	if (!rst_n)
	  	  	data_skid <= {WIDTH{1'b0}};           
	  	else if (valid_skid)
	  	  	data_skid <=  s_ready ? {WIDTH{1'b0}}: data_skid;         
	  	else if (s_ready_dge)
	  	  	data_skid <= m_data_d;      
	end 
	
	
	assign  s_valid = valid_skid || m_valid_d;        
	assign  s_data = valid_skid ? data_skid : m_data_d;    
	assign  m_ready = s_ready_d ;    
	assign s_ready_dge = s_ready ^ s_ready_d;        

endmodule 
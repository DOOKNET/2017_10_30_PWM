module tx_control(
	input clk,
	input rst_n,
	output [7:0]tx_data,
	output tx_en
);

reg [31:0]cnt=0;
always @(posedge clk) beginmodule control_module
(
    CLK, RSTn,
	 RX_Done_Sig,
	 RX_Data,
	 RX_En_Sig,
	 fre_max,
	 fre_min,
	 fre_step
);

    input CLK;
	 input RSTn;
	 input RX_Done_Sig;
	 input [7:0]RX_Data;
	 output RX_En_Sig;
	 output [23:0]fre_max;
	 output [23:0]fre_min;
	 output [23:0]fre_step;
	 
	 /******************************/
	 
	 reg [23:0]fre_max=0;
	 reg [23:0]fre_min=0;
	 reg [23:0]fre_step=0;
	 reg isEn;
	 
	 reg [23:0]fre_max_r=0;
	 reg [23:0]fre_min_r=0;
	 reg [23:0]fre_step_r=0;
	 reg [3:0]i_cnt=0;
	 
    always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn ) begin 
				i_cnt<=0;
			end
		  else     
				case(i_cnt)
					4'd0: begin i_cnt<=i_cnt+1;  isEn<=1'b1; end
					4'd1:if((RX_Data == 8'h01)&&RX_Done_Sig) begin i_cnt<=i_cnt+1; end
					4'd2:if( RX_Done_Sig ) begin fre_max_r[23:16] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd3:if( RX_Done_Sig ) begin fre_max_r[15:8] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd4:if( RX_Done_Sig ) begin fre_max_r[7:0] <= RX_Data; i_cnt<=i_cnt+1; end
					
					4'd5:if((RX_Data == 8'h02)&&RX_Done_Sig) begin i_cnt<=i_cnt+1; end
					4'd6:if( RX_Done_Sig ) begin fre_min_r[23:16] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd7:if( RX_Done_Sig ) begin fre_min_r[15:8] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd8:if( RX_Done_Sig ) begin fre_min_r[7:0] <= RX_Data; i_cnt<=i_cnt+1; end
					
					4'd9:if((RX_Data == 8'h03)&&RX_Done_Sig) begin i_cnt<=i_cnt+1; end
					4'd10:if( RX_Done_Sig ) begin fre_step_r[23:16] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd11:if( RX_Done_Sig ) begin fre_step_r[15:8] <= RX_Data; i_cnt<=i_cnt+1; end
					4'd12:if( RX_Done_Sig ) begin fre_step_r[7:0] <= RX_Data; i_cnt<=i_cnt+1; end
					
					4'd13:begin  i_cnt<=i_cnt+1; fre_max<=fre_max_r; fre_min<=fre_min_r; fre_step<=fre_step_r;  end
					4'd14:begin isEn<=0; i_cnt<=0;  end
					
				endcase

	/*********************************/
	
	assign RX_En_Sig = isEn;
	
	/*********************************/
	
endmodule

    if(~rst_n)
        cnt<=0;
    else if(cnt == 32'd49999)
        cnt<=0;
    else    
        cnt<=cnt+1;
end
assign tx_en=(cnt == 32'd49999);

reg [7:0]tx_data_r=0;
always @(posedge clk) begin
	if(~rst_n)
		tx_data_r=0;
   else if(tx_en)
        tx_data_r<=tx_data_r+1;
end

assign tx_data=tx_data_r;

endmodule
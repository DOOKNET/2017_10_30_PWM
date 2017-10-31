`timescale  1us/1ps
module tb_PWM();

reg     SCLK;
reg     [8:0]   angle;
wire    PWM;

initial
    SCLK = 0;
always
    #5
    SCLK = ~SCLK;

initial 
begin
    angle = 0;
end






endmodule 

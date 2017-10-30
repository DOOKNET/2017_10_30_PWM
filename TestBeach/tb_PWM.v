`timescale  1ns/1ps
module tb_PWM();

reg     SCLK;
reg     key1;
reg     key2;
wire    PWM;

initial
    SCLK = 0;
always
    #5
    SCLK = ~SCLK;

initial 
begin
    key1 = 0;
    key2 = 0;
end

PWM         PWM_inst(
    .sclk   (SCLK),
    .key1   (key1),
    .key2   (key2),
    .PWM    (PWM)
);




endmodule 

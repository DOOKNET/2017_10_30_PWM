module TOP(
    input   sclk,
    input   key0,   //0     -135
    input   key1,   //45    -90
    input   key2,   //90    -45
    input   key3,   //135   0
    input   key4,   //180   45
    input   key5,   //225   90
    input   key6,   //270   135
    output  PWM

);

reg     [8:0]   angle = 9'd135;

always @(posedge sclk) begin
    if(key0)    angle <= 9'd0;
    else if(key1)    angle <= 9'd45;
    else if(key2)    angle <= 9'd90;
    else if(key3)    angle <= 9'd135;
    else if(key4)    angle <= 9'd180;
    else if(key5)    angle <= 9'd225;
    else if(key6)    angle <= 9'd270;
    else angle <= angle;
end

//---------------例化---------------//
PWM_1           PWM_1(
    .sclk       (sclk),   
    .angle      (angle),
    .sig_done   (1),
    .PWM        (PWM)
);
//-----------------------------------//


endmodule 


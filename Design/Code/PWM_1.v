module PWM_1(
    input   sclk,               //100M晶振
    input   [8:0]  angle,       //舵机旋转角度，输入范围（0 ~ 270）度，无符号数
    input   sig_done,           //数据结束信号
    output  PWM
);
//================================================================================//
parameter   period = 24'd2_000_000;             //PWM波形周期20ms,频率为50Hz
parameter   pulse_min = 16'd50_000;             //最小脉宽为0.5ms
parameter   pulse_middle = 20'd150_000;         //中间脉宽为1.5ms
parameter   pulse_max = 20'd250_000;            //最大脉宽为2.5ms
parameter   pulse_step = 10'd741;               //脉宽步进1°
reg     [31:0]    cnt = 32'd0;                  //脉宽计数
reg     pulse = 0;                              //PWM脉冲
reg     pulse_r0 = 0;
reg     pulse_r1 = 0;
wire    pulse_pose;                             //PWM波形上升沿

reg     [8:0]   delta_angle = 0;                //输入角度与标准角度（135）之差
wire    [18:0]  width;                          //乘法器输出脉宽
reg     flag = 0;
reg     [19:0]  pulse_width = 20'd150_000;      //PWM脉宽

//================================================================================//

//------------计算脉宽------------//
always @(posedge sclk) begin
    if(angle <= 9'd135) begin
        delta_angle <= 9'd135 - angle;
        flag <= 0;
    end
    else if(angle > 9'd135 && angle <= 9'd270)    begin
        delta_angle <= 9'd270 - angle;
        flag <= 1;
    end
end
//-----------调用乘法器------------//
Mult    Mult_inst0(
  .A    (delta_angle),
  .B    (pulse_step),
  .P    (width)
);
//------------输出脉宽-------------//
always @(posedge sclk) begin
    if((flag == 0) && (pulse_pose == 1))   begin
        pulse_width <= pulse_middle - width;
    end
    else if((flag == 1) && (pulse_pose == 1))  begin
        pulse_width <= pulse_middle + width;
    end
    else if(pulse_pose == 1)    begin
        pulse_width <= pulse_width;
    end
end
//---------------------------------//

//---------检测PWM上升沿----------//
always @(posedge sclk) begin
    pulse_r0 <= pulse;
    pulse_r1 <= pulse_r0;
end
assign  pulse_pose = pulse_r0 & ~pulse_r1;
//----------计数器-------------//
always @(posedge sclk) begin
    if(cnt == period-1) begin
        cnt <= 32'd0;
    end
    else    begin
        cnt <= cnt + 1;
    end
end
//----------产生PWM-----------//
always @(posedge sclk) begin
    if(cnt < pulse_width-1)  begin
        pulse <= 1;
    end
    else if(cnt >= pulse_width-1)   begin
        pulse <= 0;
    end
    else   begin
        pulse <= pulse;
    end
end

assign  PWM = pulse;

endmodule 



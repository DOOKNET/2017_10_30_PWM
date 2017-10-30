module PWM(
    input   sclk,       //100M晶振
    input   key1,
    input   key2,
    output  PWM
);

parameter   period = 32'd2_000_000;             //PWM波形周期20ms,频率为50Hz
parameter   pulse_min = 32'd50_000;             //最小周期0.5ms
parameter   pulse_middle = 32'd150_000;         //中间值1.5ms
parameter   pulse_max = 32'd250_000;            //最大周期2.5ms
parameter   pulse_step = 32'd500;               //脉宽步进大小
reg     [31:0]    pulse_width = 32'd150;    //脉宽
reg     [31:0]    cnt = 32'd0;              //脉宽计数器
reg     pulse = 0;                          //PWM脉冲
reg     pulse_r0 = 0;
reg     pulse_r1 = 0;
wire    pulse_pose;                         //PWM波形上升沿

//---------检测PWM上升沿----------//
always @(posedge sclk) begin
    pulse_r0 <= pulse;
    pulse_r1 <= pulse_r0;
end
assign  pulse_pose = pulse_r0 & ~pulse_r1;
//-----------------------------//
always @(posedge sclk) begin
    if(key1 == 1)   begin
        if(pulse_width >= pulse_max-1)    begin     //当脉宽达到最大值时，脉宽值固定不变
            pulse_width <= pulse_max-1;
        end
        else    begin
            if(pulse_pose == 1) begin
                pulse_width <= pulse_width + pulse_step;    //脉宽不断增大
            end
            else    begin
                pulse_width <= pulse_width;
            end
        end
    end
    else if(key2 == 1)  begin
        if(pulse_width <= pulse_min-1)  begin
            pulse_width <= pulse_min-1;             //当脉宽达到最小值时，脉宽固定不变
        end
        else    begin
            if(pulse_pose == 1) begin
                pulse_width <= pulse_width - pulse_step;    //脉宽不断减小
            end
            else    begin
                pulse_width <= pulse_width;
            end
        end
    end
    else    begin
        pulse_width <= pulse_width;
    end
end
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
    if(cnt < pulse_width)  begin
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

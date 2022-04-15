module fibonacci_calculator (
                                input  [4:0] input_s , 
                                input  reset ,
                                input  begin_fibo , 
                                input  clk , 
                                
                                output logic done , 
                                output logic[15:0] fibo_out) ;   


//local variables
reg [4:0] input_s_reg;
reg [15:0] fibo_1, fibo_2;
reg [4:0] fibo_count;

//Always block for resetting and registering input_s
always @(posedge clk ) begin
    //synchronous reset
    if(reset) begin
        fibo_1 <= 1;
        fibo_2 <= 1;
        done <= 0;
        input_s_reg <= 0;
        fibo_count <= 0;
    end
    else if( (reset == 0) && (begin_fibo == 1) ) begin
        input_s_reg <= input_s;
    end
end

//Always block for counting the fibonacci numbers
always @(posedge clk ) begin
    if( (reset == 0) && (begin_fibo == 0) ) begin
        //Handle edge cases for n = 0, 1
        if(input_s_reg < 2) begin
            done <= 1;
            fibo_out <= 16'b1;
        end
        //Iterate n-1 times
        else if(fibo_count < (input_s_reg - 1)) begin
            fibo_1 <= fibo_2;
            fibo_2 <= fibo_1 + fibo_2;
            fibo_count <= fibo_count + 1;
        end
        else if(fibo_count >= (input_s_reg -1)) begin
            done <= 1;
            fibo_out <= fibo_2;
        end
    end
end

endmodule
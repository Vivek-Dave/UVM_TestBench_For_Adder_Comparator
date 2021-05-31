module add_comp(n1,n2,enabel_sum,sum,more,less,match);
    input [7:0] n1;
    input [7:0] n2;

    input enabel_sum;

    output reg [8:0] sum;
    output reg more;
    output reg less;
    output reg match;

    parameter pv=50;  // value to be compare with sum

    always @(*) begin
        if(enabel_sum==1) begin
            sum=n1+n2;
            if(sum==pv) begin
                match=1;
                more=0;
                less=0;
            end
            else if(sum>pv) begin
                match=0;
                more=1;
                less=0;
            end
            else begin
                match=0;
                more=0;
                less=1;
            end
        end
        else begin
            sum=0;
            more=0;
            less=0;
            match=0;
        end
    end

endmodule
`timescale 1ns/1ns
module vending_machine (
    input clk,
    input reset,
    input [1:0] item_select,
    input [7:0] money_in,
    input cancel,
    output reg dispense,
    output reg [7:0] change,
    output reg [7:0] money_needed,
    output reg [3:0] stock
    
);

    parameter IDLE = 2'b00;
    parameter WAIT_PAYMENT = 2'b01;
    parameter DISPENSE_ITEM = 2'b10;
    parameter RETURN=2'b11;

    reg [1:0] state, next_state;

    reg [7:0] prices [0:3];
    reg [3:0] stocks [0:3];
    reg [1:0] selected_item;

    reg [7:0] money_collected;

    // FSM: update state and registers on clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            money_collected <= 0;
            dispense <= 0;
            change <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    money_collected <= 0;
                    dispense <= 0;
                    change <= 0;

                    if (money_in > 0) begin
                        selected_item <= item_select;
                        money_collected <= money_in;
                    end
                end

                WAIT_PAYMENT: begin
                    if (cancel) begin
                        change <= money_collected;
                      
                        money_collected<=0;

                        money_collected <= 0;
                    end else if (money_in > 0) begin
                        money_collected <= money_collected + money_in;
                        change<=0;
                    end

                    dispense <= 0;
                    
                end

                DISPENSE_ITEM: begin
                    if (money_collected >= prices[selected_item] && stocks[selected_item] > 0) begin
                        dispense <= 1;
                        stocks[selected_item] <= stocks[selected_item] - 1;

                        if (money_collected > prices[selected_item])
                            change <= money_collected - prices[selected_item];
                        else
                            change <= 0;

                        money_collected <= 0;
                    end

                end
            endcase
        end
    end

    // FSM combinational logic
    always @(*) begin
        next_state = state;
        money_needed = 0;

        case (state)
            IDLE: begin
                if (money_in > 0)
                    next_state = WAIT_PAYMENT;
            end

            WAIT_PAYMENT: begin
                if (cancel)
                    next_state = IDLE;
                else if (money_collected >= prices[selected_item] && stocks[selected_item] > 0)
                    next_state = DISPENSE_ITEM;
                else if (money_collected < prices[selected_item])
                    money_needed = prices[selected_item] - money_collected;
            end

            DISPENSE_ITEM: begin
                next_state = IDLE;
            end
        endcase

        stock = stocks[selected_item];
    end


    initial begin
        prices[0] = 20; stocks[0] = 5;
        prices[1] = 35; stocks[1] = 3;
        prices[2] = 50; stocks[2] = 2;
        prices[3] = 45; stocks[3] = 4;
    end

endmodule

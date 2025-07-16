`timescale 1ns/1ns

`include "vendingmachine.v"

module vending_machine_tb;

    reg clk;
    reg reset;
    reg [1:0] item_select;
    reg [7:0] money_in;
    reg cancel;

    wire dispense;
    wire [7:0] change;
    wire [7:0] money_needed;
    wire [3:0] stock;

    // Instantiate the vending machine
    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .item_select(item_select),
        .money_in(money_in),
        .cancel(cancel),
        .dispense(dispense),
        .change(change),
        .money_needed(money_needed),
        .stock(stock)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0, vending_machine_tb);
        $monitor("Time=%0t | item_select=%0d | money_in=%0d | cancel=%b | dispense=%b | change=%0d | money_needed=%0d | stock=%0d", $time, item_select, money_in, cancel, dispense, change, money_needed, stock);
        $display("=== Initial Stocks at Time = %0t ===", $time);
        $display("Item no.:  Stock  Prices");
        $display("Item 0:     %0d    %0d", uut.stocks[0],uut.prices[0]);
        $display("Item 1:     %0d    %0d", uut.stocks[1],uut.prices[1]);
        $display("Item 2:     %0d    %0d", uut.stocks[2],uut.prices[2]);
        $display("Item 3:     %0d    %0d", uut.stocks[3],uut.prices[3]);
        $display("===============================");

        // Initialize signals
        clk = 0;
        reset = 1;
        item_select = 0;
        money_in = 0;
        cancel = 0;

        // Reset pulse
        #10;
        reset = 0;

        // Select Item 1 (price Rs 35) and insert Rs 20 first
        item_select = 2'b01;
        money_in = 8'd20;
        #10;
        money_in = 0;  // Stop inserting

        // Insert remaining Rs 15
        #20;
        money_in = 8'd15;
        #10;
        money_in = 0;

        // Wait to see if it dispenses
        #20;

        // Try selecting Item 2 (price Rs 50) and insert only Rs 30
        item_select = 2'b10;
        money_in = 8'd30;
        #10;
        money_in = 0;

        // Check `money_needed`
        #10;

        // Cancel transaction
        cancel = 1;
        
       
        #5;
        #10;
        cancel = 0;
        #5;

        // Select Item 3 (Rs 45), insert Rs 50 -> expect Rs 5 change
        item_select = 2'b11;
        money_in = 8'd50;
        #10;
        money_in = 0;

        // Wait to see dispense & change
        #20;

        $finish;
    end

endmodule

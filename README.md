This project implements a simple Vending Machine Controller in Verilog HDL.It models a real-world vending machine using a clean Finite State Machine (FSM) design and demonstrates core digital design concepts such as state transitions, registered outputs, combinational decision logic, and input/output handling.Some of the key features of this project are as 
follows:
1.Supports multiple items:
  Configurable list of items, each with its own stock quantity and price.
2.Handles incremental payments:
  Users can insert money in multiple steps until the required amount is reached.
3.Automatic change calculation:
  If the user inserts more than the item’s price, the machine returns the extra money as change when dispensing the item.
4.Transaction cancellation:
If the user cancels before completing the payment, the machine refunds all collected money.
5.Stock tracking:
The machine keeps track of each item’s stock level and does not dispense items that are out of stock.
6.Clean FSM states:
Uses separate states for idle, waiting for payment, dispensing items, and handling refunds — ensuring clear, safe, and predictable behavior.

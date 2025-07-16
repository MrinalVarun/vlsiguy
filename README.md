# Vending Machine Controller — Verilog HDL

This project implements a simple **Vending Machine Controller** using Verilog HDL.  
It models a real-world vending machine with a clean **Finite State Machine (FSM)** design and demonstrates core digital design concepts such as:

- State transitions
- Registered outputs
- Combinational decision logic
- Input/output handling

## 📌 Key Features

- **✅ Supports multiple items**  
  Configurable list of items, each with its own stock quantity and price.

- **✅ Handles incremental payments**  
  Users can insert money in multiple steps until the required amount is reached.

- **✅ Automatic change calculation**  
  If the user inserts more than the item’s price, the machine returns the extra money as change when dispensing the item.

- **✅ Transaction cancellation**  
  If the user cancels before completing the payment, the machine refunds all collected money.

- **✅ Stock tracking**  
  The machine keeps track of each item’s stock level and does not dispense items that are out of stock.

- **✅ Clean FSM states**  
  Uses separate states for *Idle*, *Waiting for Payment*, *Dispensing Items*, and *Handling Refunds* — ensuring clear, safe, and predictable behavior.

---

## 🛠️ Technologies

- Verilog HDL (Synthesizable)
- Icarus Verilog, ModelSim, or any other Verilog simulator

---

## 📂 Files

- `vending_machine.v` — Main FSM module  
- `vending_machine_tb.v` — Example testbench  
- `README.md` — Project description and usage instructions

---

## 🚀 How to Run

```bash
# Example simulation command
iverilog vending_machine.v vending_machine_tb.v -o vending_machine_tb or iverilog -o test.vvp vending_machine_tb.v
vvp vending_machine_tb

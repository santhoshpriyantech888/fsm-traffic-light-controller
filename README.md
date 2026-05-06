# 🚦 FSM Traffic Light Controller (Verilog)

## 📌 Overview
A traffic signal control system designed using Finite State Machine (FSM) and implemented in Verilog.

## 🎯 Objective
To simulate traffic signal behavior using digital logic and state-based control.

## 🛠️ Technologies Used
- Verilog HDL
- Digital System Design

## ⚙️ Features
- Four-state traffic system
- Safe signal transitions
- Deterministic timing behavior

## 🧩 How It Works
The system cycles through 4 states:
- A Green → A Yellow → B Green → B Yellow

Each state controls traffic signals for two roads.

┌─────────────┐
│ A_GREEN │ (5 seconds)
│ A_Red=0 │
│ B_Red=1 │
└──────┬──────┘
│ timer_done
▼
┌─────────────┐
│ A_YELLOW │ (2 seconds)
│ A_Red=0 │
│ B_Red=1 │
└──────┬──────┘
│ timer_done
▼
┌─────────────┐
│ B_GREEN │ (5 seconds)
│ A_Red=1 │
│ B_Red=0 │
└──────┬──────┘
│ timer_done
▼
┌─────────────┐
│ B_YELLOW │ (2 seconds)
│ A_Red=1 │
│ B_Red=0 │
└──────┬──────┘
│ timer_done
└──────────► (back to A_GREEN)

text

## 📊 State Encoding

| State | Binary Code | Duration | A_Green | A_Yellow | A_Red | B_Green | B_Yellow | B_Red |
|-------|-------------|----------|---------|----------|-------|---------|----------|-------|
| A_GREEN | 00 | 5 sec | 1 | 0 | 0 | 0 | 0 | 1 |
| A_YELLOW | 01 | 2 sec | 0 | 1 | 0 | 0 | 0 | 1 |
| B_GREEN | 10 | 5 sec | 0 | 0 | 1 | 1 | 0 | 0 |
| B_YELLOW | 11 | 2 sec | 0 | 0 | 1 | 0 | 1 | 0 |

## ✨ Features

- ✅ Four clearly defined states with deterministic transitions
- ✅ Configurable timing intervals (5s Green, 2s Yellow)
- ✅ Safety-critical design - prevents conflicting green signals
- ✅ Synchronous design with clock-driven state transitions
- ✅ Synchronous reset for reliable initialization
- ✅ FPGA-ready Verilog implementation
- ✅ Complete testbench with waveform validation

## 🔧 Technologies Used

- **Language:** Verilog HDL
- **Simulation:** ModelSim / Vivado
- **Methodology:** ASM (Algorithmic State Machine)
- **State Encoding:** Binary (2 flip-flops)

## 📁 Files

| File | Description |
|------|-------------|
| `traffic_controller.v` | Main Verilog module |
| `testbench.v` | Simulation testbench |

## 🚀 How to Run

### Using ModelSim
```bash
vlib work
vlog traffic_controller.v testbench.v
vsim -c testbench
run -all

## ▶️ How to Run
1. Use ModelSim / Vivado
2. Compile traffic_controller.v
3. Simulate waveform

## 📚 Concepts Used
- FSM (Finite State Machine)
- ASM Design
- Sequential Logic

## 🔮 Future Improvements
- Add timers
- Sensor-based control
- Smart traffic integration

## 👨‍💻 Author
Santhosa Priyan

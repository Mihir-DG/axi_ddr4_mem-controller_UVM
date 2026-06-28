#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "obj_dir/Vrst_sync.h"
#include "obj_dir/Vrst_sync___024root.h"

#define MAX_SIM_TIME 100
vluint64_t sim_time = 0; //used to track when to finish the simulation

int main(int argc, char** argv, char** env) {

    Verilated::commandArgs(argc, argv);
    Vrst_sync *dut = new Vrst_sync; // instantiation;
    // system verilog equivalent --> alu dut(.*);

    //setting up waveform dumping
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("rst_sync_waveform.vcd");

    dut->clk = 0;
    dut->async_rst_n = 0;
    dut->sync_rst_n = 0;

    // SIMULATION MEAT AND BONES RAHHHHH
    while (sim_time < MAX_SIM_TIME){
        if ((sim_time % 10) == 0) {
            dut->clk = 0; // Falling edge at 0, 10, 20, 30...
        } else if ((sim_time % 10) == 5) {
            dut->clk = 1; // Rising edge at 5, 15, 25, 35...
        }
        if (sim_time == 42){
            dut->async_rst_n = 0; // driving IN low to check OUT speed following
        }
        if (sim_time == 7){
            dut->async_rst_n = 1; // driving IN high to check OUT speed following
        }
        //dut->async_rst_n = 1;
        dut->eval(); // evalulates all signals module
        m_trace->dump(sim_time); // dumps traced signal values into waveform dump file
        // model is currently only evaluated at clock edges
        sim_time ++; // increment sim time
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
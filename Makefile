# Makefile for Verilator simulation

# === Variables ===
TOP_MODULE     := tb_can_top
SRC_RTL        := $(wildcard RTL/*.v)
SRC_SIM        := $(wildcard SIM/*.v)
VERILATOR_OPTS := -CFLAGS -fcoroutines --cc --main --build --exe --timing --trace -Wno-fatal --top-module $(TOP_MODULE)
TARGET         := sim_$(TOP_MODULE)

# === Default target ===
all: $(TARGET)

# === Verilator build rule ===
$(TARGET):
	verilator $(VERILATOR_OPTS) $(SRC_SIM) $(SRC_RTL)

# === Run simulation ===
run: $(TARGET)
	./obj_dir/V$(TOP_MODULE)

wave: 
	gtkwave can_trace.vcd &

# === Clean ===
clean:
	rm -rf obj_dir $(TARGET) *.vcd *.log

.PHONY: all run clean
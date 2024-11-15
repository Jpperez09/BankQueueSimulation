# Compiler and flags
CC = gcc
CFLAGS = -fopenmp -Wall -O2

# Directories
SRC_DIR = src
BUILD_DIR = build

# Target executable name
TARGET = BankQueueSimulation

# Source files and object files
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC_FILES))

# Default target to build the program
all: $(TARGET)

# Linking the object files to create the executable
$(TARGET): $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $@ $^

# Compiling each .c file to an .o file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create the build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean up build files
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

# Run scenarios
run_normal:
	@.\$(TARGET) 480 3 5 > simulation_output.txt
	@python gui/gui.py run_normal

run_rush_hour:
	@.\$(TARGET) 240 5 2 > simulation_output.txt
	@python gui/gui.py run_rush_hour

run_off_peak:
	@.\$(TARGET) 480 2 10 > simulation_output.txt
	@python gui/gui.py run_off_peak

# Run GUI after running the normal simulation
run_gui:
	@python gui/gui.py

# Help command to list all available make commands
help:
	@echo "Available make commands:"
	@echo "  all            - Compile the program"
	@echo "  clean          - Remove all build files"
	@echo "  run_normal     - Run the normal simulation (8 hours, 3 tellers, avg. 5 min between arrivals)"
	@echo "  run_rush_hour  - Run the rush hour simulation (4 hours, 5 tellers, avg. 2 min between arrivals)"
	@echo "  run_off_peak   - Run the off-peak simulation (8 hours, 2 tellers, avg. 10 min between arrivals)"
	@echo "  run_gui        - Run the GUI to display simulation results"

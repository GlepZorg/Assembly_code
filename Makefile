CC = gcc
AS = as
LD = gcc
CFLAGS = -Wall -g
LDFLAGS = -lm
TARGET = solitaire

all: $(TARGET)

$(TARGET): main.o generate_starting_configuration.o perform_solitaire_step.o check_final_configuration.o print_piles.o
	$(LD) -o $@ $^ $(LDFLAGS)

main.o: main.s
	$(AS) -o $@ $<

generate_starting_configuration.o: generate_starting_configuration.s
	$(AS) -o $@ $<

perform_solitaire_step.o: perform_solitaire_step.s
	$(AS) -o $@ $<

check_final_configuration.o: check_final_configuration.s
	$(AS) -o $@ $<

print_piles.o: print_piles.s
	$(AS) -o $@ $<

clean:
	rm -f *.o $(TARGET)


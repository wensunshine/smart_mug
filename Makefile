#CC=$(shell echo "$$CC")
#CXX=$(shell echo "$$CXX")

IOHUB_ROOT='../edison'

INC_PATH=$(IOHUB_ROOT)/lib/include
LIB_PATH=$(IOHUB_ROOT)/lib/bin

BIN_PATH=bin
SRC_PATH=src
BUILD_PATH=build
TARGET=$(BIN_PATH)/libmug.a

SRCS=disp.cpp image.cpp

C_FLAGS=-O0 -g -I$(INC_PATH) -Iinclude -Ilib/CImg

OBJS=$(addprefix $(BUILD_PATH)/, $(SRCS:.cpp=.o))

all: init $(TARGET) end

end:
	@echo "done"

init:
	@mkdir -p bin
	@mkdir -p build

$(TARGET):$(OBJS)
	cp $(LIB_PATH)/libiohub-client.a $(TARGET)
	ar -rc $@ $^

$(BUILD_PATH)/%.o: $(SRC_PATH)/%.cpp
	$(CXX) $(C_FLAGS) -c $< -o $@

test:
	make -C test

clean:
	rm -rf build
	rm -rf bin
	make clean -C test

.PHONY: clean all test




#! /bin/bash -x
openocd \
-c "interface jlink" \
-c "transport select jtag" \
-c "adapter_khz 14000" \
-c "gdb_port 3333" \
-c "telnet_port 4444" \
-c "set _CHIPNAME riscv" \
-c "jtag newtap \$_CHIPNAME cpu -irlen 5 -expected-id 0x04e4796b" \
-c "set _TARGETNAME \$_CHIPNAME.cpu" \
-c "target create \$_TARGETNAME riscv -chain-position \$_TARGETNAME" \
-c "init" \
-c "halt" \
-c "load_image ${1} 0x80000000 bin" \
-c "verify_image ${1} 0x80000000 bin" \
-c "resume 0x80000000" \
-c "exit"

library verilog;
use verilog.vl_types.all;
entity tribuf is
    port(
        \out\           : out    vl_logic;
        \in\            : in     vl_logic;
        control         : in     vl_logic
    );
end tribuf;

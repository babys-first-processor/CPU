library verilog;
use verilog.vl_types.all;
entity dff_async_reset is
    port(
        q               : out    vl_logic;
        data            : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic
    );
end dff_async_reset;

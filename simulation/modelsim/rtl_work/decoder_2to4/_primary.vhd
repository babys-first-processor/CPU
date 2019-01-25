library verilog;
use verilog.vl_types.all;
entity decoder_2to4 is
    port(
        Y3              : out    vl_logic;
        Y2              : out    vl_logic;
        Y1              : out    vl_logic;
        Y0              : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        en              : in     vl_logic
    );
end decoder_2to4;

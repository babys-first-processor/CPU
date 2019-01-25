library verilog;
use verilog.vl_types.all;
entity regfile32x64 is
    port(
        clk             : in     vl_logic;
        write           : in     vl_logic;
        wrAddr          : in     vl_logic_vector(4 downto 0);
        wrData          : in     vl_logic_vector(63 downto 0);
        rdAddrA         : in     vl_logic_vector(4 downto 0);
        rdDataA         : out    vl_logic_vector(63 downto 0);
        rdAddrB         : in     vl_logic_vector(4 downto 0);
        rdDataB         : out    vl_logic_vector(63 downto 0)
    );
end regfile32x64;

library verilog;
use verilog.vl_types.all;
entity CLA_adder64bit is
    port(
        A               : in     vl_logic_vector(63 downto 0);
        B               : in     vl_logic_vector(63 downto 0);
        S               : out    vl_logic_vector(63 downto 0);
        CF              : out    vl_logic
    );
end CLA_adder64bit;

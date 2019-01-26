library verilog;
use verilog.vl_types.all;
entity CLA_adder4bit is
    port(
        Cin             : in     vl_logic;
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        S               : out    vl_logic_vector(3 downto 0);
        Cout            : out    vl_logic
    );
end CLA_adder4bit;

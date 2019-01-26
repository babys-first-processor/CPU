library verilog;
use verilog.vl_types.all;
entity CLA_logic is
    port(
        P               : in     vl_logic_vector(3 downto 0);
        G               : in     vl_logic_vector(3 downto 0);
        Cin             : in     vl_logic;
        C               : out    vl_logic_vector(3 downto 0)
    );
end CLA_logic;

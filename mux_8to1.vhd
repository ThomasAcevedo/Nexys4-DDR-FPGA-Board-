library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8to1 is
    generic (
        n : integer := 4
    );
    port (
        sel  : in  std_logic_vector(2 downto 0);
        in0  : in  std_logic_vector(n-1 downto 0);
        in1  : in  std_logic_vector(n-1 downto 0);
        in2  : in  std_logic_vector(n-1 downto 0);
        in3  : in  std_logic_vector(n-1 downto 0);
        in4  : in  std_logic_vector(n-1 downto 0);
        in5  : in  std_logic_vector(n-1 downto 0);
        in6  : in  std_logic_vector(n-1 downto 0);
        in7  : in  std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0)
    );
end mux_8to1;

architecture Behavioral of mux_8to1 is
begin
    process(sel, in0, in1, in2, in3, in4, in5, in6, in7)
    begin
        case sel is
            when "000"  => dout <= in0;
            when "001"  => dout <= in1;
            when "010"  => dout <= in2;
            when "011"  => dout <= in3;
            when "100"  => dout <= in4;
            when "101"  => dout <= in5;
            when "110"  => dout <= in6;
            when "111"  => dout <= in7;
            when others => dout <= (others => '0');
        end case;
    end process;
end Behavioral;

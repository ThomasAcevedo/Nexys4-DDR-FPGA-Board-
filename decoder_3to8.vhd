library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_3to8 is
    port (
        din  : in  std_logic_vector(2 downto 0);
        en   : in  std_logic;
        dout : out std_logic_vector(7 downto 0)
    );
end decoder_3to8;

architecture Behavioral of decoder_3to8 is
begin
    process(din, en)
    begin
        if en = '1' then
            case din is
                when "000" => dout <= "00000001";
                when "001" => dout <= "00000010";
                when "010" => dout <= "00000100";
                when "011" => dout <= "00001000";
                when "100" => dout <= "00010000";
                when "101" => dout <= "00100000";
                when "110" => dout <= "00100000";
                when "111" => dout <= "10000000";
                when others => dout <= "00000000";
            end case;
        else
            dout <= "00000000";
        end if;
    end process;
end Behavioral;

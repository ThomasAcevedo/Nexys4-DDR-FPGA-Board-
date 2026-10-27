library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_reg_file is
end tb_reg_file;

architecture Behavior of tb_reg_file is

    component reg_file is
        port (
            clk  : in  std_logic;
            rst  : in  std_logic;
            we   : in  std_logic;
            addr : in  std_logic_vector(2 downto 0);
            din  : in  std_logic_vector(3 downto 0);
            dout : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '1';
    signal we   : std_logic := '0';
    signal addr : std_logic_vector(2 downto 0) := "000";
    signal din  : std_logic_vector(3 downto 0) := "0000";
    signal dout : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: reg_file
        port map (
            clk  => clk,
            rst  => rst,
            we   => we,
            addr => addr,
            din  => din,
            dout => dout
        );

    -- Clock Process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- 1. Reset setup
        rst <= '0'; -- Assert reset
        wait for 20 ns;
        rst <= '1'; -- De-assert reset
        wait for 10 ns;

        -- 2. Write test values into each register (0 to 7)
        we <= '1';
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, 3));
            din  <= std_logic_vector(to_unsigned(i + 5, 4));
            wait for clk_period;
        end loop;

        -- 3. Read test values back
        we <= '0';
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, 3));
            wait for clk_period;
        end loop;

        -- 4. Assert reset and check values are cleared
        rst <= '0';
        wait for 10 ns;

        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, 3));
            wait for clk_period;
        end loop;

        wait;
    end process;

end Behavior;

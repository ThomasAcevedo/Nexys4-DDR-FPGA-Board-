library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg_file is
end entity tb_reg_file;

architecture behavior of tb_reg_file is
    constant clk_period : time := 10 ns;
    type word_array is array (0 to 7) of std_logic_vector(3 downto 0);
    -- These are the same values from the supplied sim.txt.
    constant expected : word_array := (
        "0111", "1101", "1011", "0010",
        "1010", "1110", "1001", "1100"
    );

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '0'; -- asynchronous active-low reset
    signal we   : std_logic := '0';
    signal addr : std_logic_vector(2 downto 0) := (others => '0');
    signal din  : std_logic_vector(3 downto 0) := (others => '0');
    signal dout : std_logic_vector(3 downto 0);
begin
    dut : entity work.reg_file(Structural)
        port map (
            clk => clk, rst => rst, we => we,
            addr => addr, din => din, dout => dout
        );

    clk <= not clk after clk_period / 2;

    stimulus : process
    begin
        -- Check all eight locations while asynchronous reset is asserted.
        wait for 1 ns;
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for 1 ns;
            assert dout = "0000"
                report "Initial reset failed at address " & integer'image(i)
                severity error;
        end loop;
        rst <= '1';

        -- Write the provided sim.txt values, one per selected address.
        we <= '1';
        for i in 0 to 7 loop
            wait until falling_edge(clk);
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            din <= expected(i);
            wait until rising_edge(clk);
        end loop;
        we <= '0';

        -- Read back and verify each register.
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for 1 ns;
            assert dout = expected(i)
                report "Readback mismatch at address " & integer'image(i)
                severity error;
        end loop;

        -- Reset between clock edges and verify asynchronous clearing.
        wait until falling_edge(clk);
        rst <= '0';
        wait for 1 ns;
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, addr'length));
            wait for 1 ns;
            assert dout = "0000"
                report "Reset failed at address " & integer'image(i)
                severity error;
        end loop;

        rst <= '1';
        report "All register-file checks passed." severity note;
        wait;
    end process;
end architecture behavior;

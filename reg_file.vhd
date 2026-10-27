library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_file is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic; -- Asynchronous active low reset
        we   : in  std_logic;
        addr : in  std_logic_vector(2 downto 0);
        din  : in  std_logic_vector(3 downto 0);
        dout : out std_logic_vector(3 downto 0)
    );
end reg_file;

architecture Structural of reg_file is

    -- Component Declarations
    component decoder_3to8 is
        port (
            din  : in  std_logic_vector(2 downto 0);
            en   : in  std_logic;
            dout : out std_logic_vector(7 downto 0)
        );
    end component;

    component reg_module is
        generic ( n : integer := 4 );
        port (
            clk  : in  std_logic;
            rst  : in  std_logic;
            we   : in  std_logic;
            din  : in  std_logic_vector(n-1 downto 0);
            dout : out std_logic_vector(n-1 downto 0)
        );
    end component;

    component mux_8to1 is
        generic ( n : integer := 4 );
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
    end component;

    -- Internal Signals
    signal dec_out : std_logic_vector(7 downto 0);
    signal r0_out, r1_out, r2_out, r3_out : std_logic_vector(3 downto 0);
    signal r4_out, r5_out, r6_out, r7_out : std_logic_vector(3 downto 0);

begin

    -- Decoder Instance
    u_decoder: decoder_3to8
        port map (
            din  => addr,
            en   => we,
            dout => dec_out
        );

    -- 8 Register Instances
    reg0: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(0), din => din, dout => r0_out);
    reg1: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(1), din => din, dout => r1_out);
    reg2: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(2), din => din, dout => r2_out);
    reg3: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(3), din => din, dout => r3_out);
    reg4: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(4), din => din, dout => r4_out);
    reg5: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(5), din => din, dout => r5_out);
    reg6: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(6), din => din, dout => r6_out);
    reg7: reg_module generic map (n => 4) port map (clk => clk, rst => rst, we => dec_out(7), din => din, dout => r7_out);

    -- Multiplexer Instance
    u_mux: mux_8to1 generic map (n => 4)
        port map (
            sel  => addr,
            in0  => r0_out,
            in1  => r1_out,
            in2  => r2_out,
            in3  => r3_out,
            in4  => r4_out,
            in5  => r5_out,
            in6  => r6_out,
            in7  => r7_out,
            dout => dout
        );

end Structural;

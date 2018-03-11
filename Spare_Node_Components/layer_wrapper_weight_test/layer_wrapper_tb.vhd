library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity layer_wrapper_tb is Generic (
              CTL_SZE : integer := 4;
              LY_ADDR_SZE :   integer :=  3;   
              LAYER_SZE   :   integer :=  8;
              ND_ADDR_SZE : integer := 3;
              NODE_SZE : integer := 8
);
end;

architecture bench of layer_wrapper_tb is

  component layer_wrapper Generic (
              CTL_SZE : integer := 4;
              LY_ADDR_SZE :   integer :=  3;   
              LAYER_SZE   :   integer :=  8;
              ND_ADDR_SZE : integer := 3;
              NODE_SZE : integer := 8
  );
  Port (
              CLK : IN STD_LOGIC;
              LAYER_CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
              LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
              NODE : IN STD_LOGIC_VECTOR(ND_ADDR_SZE - 1 downto 0);
              IN_0 : IN SIGNED(15 downto 0);
              IN_1 : IN SIGNED(15 downto 0);
              IN_2 : IN SIGNED(15 downto 0);
              IN_3 : IN SIGNED(15 downto 0);
              IN_4 : IN SIGNED(15 downto 0);
              IN_5 : IN SIGNED(15 downto 0);
              IN_6 : IN SIGNED(15 downto 0);
              IN_7 : IN SIGNED(15 downto 0);
              WIN_0 : IN SIGNED(15 downto 0);
              WIN_1 : IN SIGNED(15 downto 0);
              WIN_2 : IN SIGNED(15 downto 0);
              WIN_3 : IN SIGNED(15 downto 0);
              WIN_4 : IN SIGNED(15 downto 0);
              WIN_5 : IN SIGNED(15 downto 0);
              WIN_6 : IN SIGNED(15 downto 0);
              WIN_7 : IN SIGNED(15 downto 0);
              OUT_0 : OUT SIGNED(15 downto 0);
              OUT_1 : OUT SIGNED(15 downto 0);
              OUT_2 : OUT SIGNED(15 downto 0);
              OUT_3 : OUT SIGNED(15 downto 0);
              OUT_4 : OUT SIGNED(15 downto 0);
              OUT_5 : OUT SIGNED(15 downto 0);
              OUT_6 : OUT SIGNED(15 downto 0);
              OUT_7 : OUT SIGNED(15 downto 0);
              WOUT_0 : OUT SIGNED(15 downto 0);
              WOUT_1 : OUT SIGNED(15 downto 0);
              WOUT_2 : OUT SIGNED(15 downto 0);
              WOUT_3 : OUT SIGNED(15 downto 0);
              WOUT_4 : OUT SIGNED(15 downto 0);
              WOUT_5 : OUT SIGNED(15 downto 0);
              WOUT_6 : OUT SIGNED(15 downto 0);
              WOUT_7 : OUT SIGNED(15 downto 0)
  );
  end component;

  signal CLK: STD_LOGIC;
  signal LAYER_CTL: STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
  signal LAYER: STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
  signal NODE: STD_LOGIC_VECTOR(ND_ADDR_SZE - 1 downto 0);
  signal IN_0: SIGNED(15 downto 0);
  signal IN_1: SIGNED(15 downto 0);
  signal IN_2: SIGNED(15 downto 0);
  signal IN_3: SIGNED(15 downto 0);
  signal IN_4: SIGNED(15 downto 0);
  signal IN_5: SIGNED(15 downto 0);
  signal IN_6: SIGNED(15 downto 0);
  signal IN_7: SIGNED(15 downto 0);
  signal WIN_0: SIGNED(15 downto 0);
  signal WIN_1: SIGNED(15 downto 0);
  signal WIN_2: SIGNED(15 downto 0);
  signal WIN_3: SIGNED(15 downto 0);
  signal WIN_4: SIGNED(15 downto 0);
  signal WIN_5: SIGNED(15 downto 0);
  signal WIN_6: SIGNED(15 downto 0);
  signal WIN_7: SIGNED(15 downto 0);
  signal OUT_0: SIGNED(15 downto 0);
  signal OUT_1: SIGNED(15 downto 0);
  signal OUT_2: SIGNED(15 downto 0);
  signal OUT_3: SIGNED(15 downto 0);
  signal OUT_4: SIGNED(15 downto 0);
  signal OUT_5: SIGNED(15 downto 0);
  signal OUT_6: SIGNED(15 downto 0);
  signal OUT_7: SIGNED(15 downto 0);
  signal WOUT_0: SIGNED(15 downto 0);
  signal WOUT_1: SIGNED(15 downto 0);
  signal WOUT_2: SIGNED(15 downto 0);
  signal WOUT_3: SIGNED(15 downto 0);
  signal WOUT_4: SIGNED(15 downto 0);
  signal WOUT_5: SIGNED(15 downto 0);
  signal WOUT_6: SIGNED(15 downto 0);
  signal WOUT_7: SIGNED(15 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: layer_wrapper generic map ( CTL_SZE     => CTL_SZE,
                                   LY_ADDR_SZE => LY_ADDR_SZE,
                                   LAYER_SZE   => LAYER_SZE,
                                   ND_ADDR_SZE => ND_ADDR_SZE,
                                   NODE_SZE    =>  NODE_SZE)
                        port map ( CLK         => CLK,
                                   LAYER_CTL   => LAYER_CTL,
                                   LAYER       => LAYER,
                                   NODE        => NODE,
                                   IN_0        => IN_0,
                                   IN_1        => IN_1,
                                   IN_2        => IN_2,
                                   IN_3        => IN_3,
                                   IN_4        => IN_4,
                                   IN_5        => IN_5,
                                   IN_6        => IN_6,
                                   IN_7        => IN_7,
                                   WIN_0       => WIN_0,
                                   WIN_1       => WIN_1,
                                   WIN_2       => WIN_2,
                                   WIN_3       => WIN_3,
                                   WIN_4       => WIN_4,
                                   WIN_5       => WIN_5,
                                   WIN_6       => WIN_6,
                                   WIN_7       => WIN_7,
                                   OUT_0       => OUT_0,
                                   OUT_1       => OUT_1,
                                   OUT_2       => OUT_2,
                                   OUT_3       => OUT_3,
                                   OUT_4       => OUT_4,
                                   OUT_5       => OUT_5,
                                   OUT_6       => OUT_6,
                                   OUT_7       => OUT_7,
                                   WOUT_0      => WOUT_0,
                                   WOUT_1      => WOUT_1,
                                   WOUT_2      => WOUT_2,
                                   WOUT_3      => WOUT_3,
                                   WOUT_4      => WOUT_4,
                                   WOUT_5      => WOUT_5,
                                   WOUT_6      => WOUT_6,
                                   WOUT_7      => WOUT_7 );

  stimulus: process
  begin
CLK <= '0';
  LAYER_CTL <= x"1";
  LAYER <= "010";
  NODE <= "000";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"2000";
  WIN_1 <= x"2000";
  WIN_2 <= x"2000";
  WIN_3 <= x"2000";
  WIN_4 <= x"2000";
  WIN_5 <= x"2000";
  WIN_6 <= x"2000";
  WIN_7 <= x"2000";
  wait for 20 ns;
  CLK <= '1';
  LAYER_CTL <= x"1";
  LAYER <= "010";
  NODE <= "000";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"2000";
  WIN_1 <= x"2000";
  WIN_2 <= x"2000";
  WIN_3 <= x"2000";
  WIN_4 <= x"2000";
  WIN_5 <= x"2000";
  WIN_6 <= x"2000";
  WIN_7 <= x"2000";
  wait for 20 ns;
  CLK <= '0';
  LAYER_CTL <= x"1";
  LAYER <= "100";
  NODE <= "001";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"4000";
  WIN_1 <= x"4000";
  WIN_2 <= x"4000";
  WIN_3 <= x"4000";
  WIN_4 <= x"4000";
  WIN_5 <= x"4000";
  WIN_6 <= x"4000";
  WIN_7 <= x"4000";
  wait for 20 ns;
  CLK <= '1';
  LAYER_CTL <= x"1";
  LAYER <= "100";
  NODE <= "001";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"4000";
  WIN_1 <= x"4000";
  WIN_2 <= x"4000";
  WIN_3 <= x"4000";
  WIN_4 <= x"4000";
  WIN_5 <= x"4000";
  WIN_6 <= x"4000";
  WIN_7 <= x"4000";
  wait for 20 ns;
  CLK <= '0';
  LAYER_CTL <= x"0";
  LAYER <= "010";
  NODE <= "000";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"0000";
  WIN_1 <= x"0000";
  WIN_2 <= x"0000";
  WIN_3 <= x"0000";
  WIN_4 <= x"0000";
  WIN_5 <= x"0000";
  WIN_6 <= x"0000";
  WIN_7 <= x"0000";
  wait for 20 ns;
  CLK <= '1';
  LAYER_CTL <= x"0";
  LAYER <= "010";
  NODE <= "000";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"0000";
  WIN_1 <= x"0000";
  WIN_2 <= x"0000";
  WIN_3 <= x"0000";
  WIN_4 <= x"0000";
  WIN_5 <= x"0000";
  WIN_6 <= x"0000";
  WIN_7 <= x"0000";
  wait for 20 ns;
  CLK <= '0';
  LAYER_CTL <= x"0";
  LAYER <= "100";
  NODE <= "001";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"0000";
  WIN_1 <= x"0000";
  WIN_2 <= x"0000";
  WIN_3 <= x"0000";
  WIN_4 <= x"0000";
  WIN_5 <= x"0000";
  WIN_6 <= x"0000";
  WIN_7 <= x"0000";
  wait for 20 ns;
  CLK <= '1';
  LAYER_CTL <= x"0";
  LAYER <= "100";
  NODE <= "001";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"0000";
  WIN_1 <= x"0000";
  WIN_2 <= x"0000";
  WIN_3 <= x"0000";
  WIN_4 <= x"0000";
  WIN_5 <= x"0000";
  WIN_6 <= x"0000";
  WIN_7 <= x"0000";
  wait for 20 ns;
  CLK <= '0';
  LAYER_CTL <= x"0";
  LAYER <= "100";
  NODE <= "000";
  IN_0 <= x"0000";
  IN_1 <= x"0000";
  IN_2 <= x"0000";
  IN_3 <= x"0000";
  IN_4 <= x"0000";
  IN_5 <= x"0000";
  IN_6 <= x"0000";
  IN_7 <= x"0000";
  WIN_0 <= x"0000";
  WIN_1 <= x"0000";
  WIN_2 <= x"0000";
  WIN_3 <= x"0000";
  WIN_4 <= x"0000";
  WIN_5 <= x"0000";
  WIN_6 <= x"0000";
  WIN_7 <= x"0000";
  wait for 100 ns;
  end process;


end;

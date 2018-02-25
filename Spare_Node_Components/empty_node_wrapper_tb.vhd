library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity empty_node_wrapper_tb is Generic (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8
);
end;

architecture bench of empty_node_wrapper_tb is

  component empty_node_wrapper
  Generic (
              CTL_SZE : integer := 4;
              LY_ADDR_SZE :   integer :=  3;   
              LAYER_SZE   :   integer :=  8
  );
  Port (
              CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
              LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
              IN_0 : IN SIGNED(15 downto 0);
              IN_1 : IN SIGNED(15 downto 0);
              IN_2 : IN SIGNED(15 downto 0);
              IN_3 : IN SIGNED(15 downto 0);
              IN_4 : IN SIGNED(15 downto 0);
              IN_5 : IN SIGNED(15 downto 0);
              IN_6 : IN SIGNED(15 downto 0);
              IN_7 : IN SIGNED(15 downto 0);
              OUT_0 : OUT SIGNED(15 downto 0);
              OUT_1 : OUT SIGNED(15 downto 0);
              OUT_2 : OUT SIGNED(15 downto 0);
              OUT_3 : OUT SIGNED(15 downto 0);
              OUT_4 : OUT SIGNED(15 downto 0);
              OUT_5 : OUT SIGNED(15 downto 0);
              OUT_6 : OUT SIGNED(15 downto 0);
              OUT_7 : OUT SIGNED(15 downto 0));
  end component;

  signal CTL: STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
  signal LAYER: STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
  signal IN_0: SIGNED(15 downto 0);
  signal IN_1: SIGNED(15 downto 0);
  signal IN_2: SIGNED(15 downto 0);
  signal IN_3: SIGNED(15 downto 0);
  signal IN_4: SIGNED(15 downto 0);
  signal IN_5: SIGNED(15 downto 0);
  signal IN_6: SIGNED(15 downto 0);
  signal IN_7: SIGNED(15 downto 0);
  signal OUT_0: SIGNED(15 downto 0);
  signal OUT_1: SIGNED(15 downto 0);
  signal OUT_2: SIGNED(15 downto 0);
  signal OUT_3: SIGNED(15 downto 0);
  signal OUT_4: SIGNED(15 downto 0);
  signal OUT_5: SIGNED(15 downto 0);
  signal OUT_6: SIGNED(15 downto 0);
  signal OUT_7: SIGNED(15 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: empty_node_wrapper generic map ( CTL_SZE     => CTL_SZE,
                                        LY_ADDR_SZE => LY_ADDR_SZE,
                                        LAYER_SZE   => LAYER_SZE)
                             port map ( CTL         => CTL,
                                        LAYER       => LAYER,
                                        IN_0        => IN_0,
                                        IN_1        => IN_1,
                                        IN_2        => IN_2,
                                        IN_3        => IN_3,
                                        IN_4        => IN_4,
                                        IN_5        => IN_5,
                                        IN_6        => IN_6,
                                        IN_7        => IN_7,
                                        OUT_0       => OUT_0,
                                        OUT_1       => OUT_1,
                                        OUT_2       => OUT_2,
                                        OUT_3       => OUT_3,
                                        OUT_4       => OUT_4,
                                        OUT_5       => OUT_5,
                                        OUT_6       => OUT_6,
                                        OUT_7       => OUT_7 );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity sum_block_tb is
end;

architecture bench of sum_block_tb is

  component sum_block Port (
                              val0: IN SIGNED(31 downto 0);
                              val1: IN SIGNED(31 downto 0);
                              val2: IN SIGNED(31 downto 0);
                              val3: IN SIGNED(31 downto 0);
                              val4: IN SIGNED(31 downto 0);
                              val5: IN SIGNED(31 downto 0);
                              val6: IN SIGNED(31 downto 0);
                              val7: IN SIGNED(31 downto 0);
                              sum: OUT SIGNED(35 downto 0));
  end component;

  signal val0: SIGNED(31 downto 0);
  signal val1: SIGNED(31 downto 0);
  signal val2: SIGNED(31 downto 0);
  signal val3: SIGNED(31 downto 0);
  signal val4: SIGNED(31 downto 0);
  signal val5: SIGNED(31 downto 0);
  signal val6: SIGNED(31 downto 0);
  signal val7: SIGNED(31 downto 0);
  signal sum: SIGNED(35 downto 0);

begin

  uut: sum_block port map ( val0 => val0,
                            val1 => val1,
                            val2 => val2,
                            val3 => val3,
                            val4 => val4,
                            val5 => val5,
                            val6 => val6,
                            val7 => val7,
                            sum  => sum );

  stimulus: process begin
  val0 <= x"00000000";
  val1 <= x"00000000";
  val2 <= x"00000000";
  val3 <= x"00000000";
  val4 <= x"00000000";
  val5 <= x"00000000";
  val6 <= x"00000000";
  val7 <= x"00000000";
  
  val0 <= x"30000000";
  val1 <= x"20000000";
  wait for 10 ns;
  val0 <= x"10000000";
  val1 <= x"F0000000";
  wait for 10 ns;
  val0 <= x"F0000000";
  val1 <= x"E0000000";
  wait for 10 ns;
  val0 <= x"30000000";
  val1 <= x"40000000";
  wait for 10 ns;
  val0 <= x"B0000000";
  val1 <= x"A0000000";
  wait for 10 ns;
    wait;
  end process;


end;
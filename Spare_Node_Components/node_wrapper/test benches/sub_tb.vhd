library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bp_subtract_block_tb is
end;

architecture bench of bp_subtract_block_tb is

  component bp_subtract_block Port (
              BASE_0 :IN SIGNED(15 downto 0);
              SUB_0 : IN SIGNED(15 downto 0);
              BASE_1 :IN SIGNED(15 downto 0);
              SUB_1 : IN SIGNED(15 downto 0);
              BASE_2 :IN SIGNED(15 downto 0);
              SUB_2 : IN SIGNED(15 downto 0);
              BASE_3 :IN SIGNED(15 downto 0);
              SUB_3 : IN SIGNED(15 downto 0);
              BASE_4 :IN SIGNED(15 downto 0);
              SUB_4 : IN SIGNED(15 downto 0);
              BASE_5 :IN SIGNED(15 downto 0);
              SUB_5 : IN SIGNED(15 downto 0);
              BASE_6 :IN SIGNED(15 downto 0);
              SUB_6 : IN SIGNED(15 downto 0);
              BASE_7 :IN SIGNED(15 downto 0);
              SUB_7 : IN SIGNED(15 downto 0);
              DIFF_0 : OUT SIGNED(15 downto 0);
              DIFF_1 : OUT SIGNED(15 downto 0);
              DIFF_2 : OUT SIGNED(15 downto 0);
              DIFF_3 : OUT SIGNED(15 downto 0);
              DIFF_4 : OUT SIGNED(15 downto 0);
              DIFF_5 : OUT SIGNED(15 downto 0);
              DIFF_6 : OUT SIGNED(15 downto 0);
              DIFF_7 : OUT SIGNED(15 downto 0));
  end component;

  signal BASE_0: SIGNED(15 downto 0);
  signal SUB_0: SIGNED(15 downto 0);
  signal BASE_1: SIGNED(15 downto 0);
  signal SUB_1: SIGNED(15 downto 0);
  signal BASE_2: SIGNED(15 downto 0);
  signal SUB_2: SIGNED(15 downto 0);
  signal BASE_3: SIGNED(15 downto 0);
  signal SUB_3: SIGNED(15 downto 0);
  signal BASE_4: SIGNED(15 downto 0);
  signal SUB_4: SIGNED(15 downto 0);
  signal BASE_5: SIGNED(15 downto 0);
  signal SUB_5: SIGNED(15 downto 0);
  signal BASE_6: SIGNED(15 downto 0);
  signal SUB_6: SIGNED(15 downto 0);
  signal BASE_7: SIGNED(15 downto 0);
  signal SUB_7: SIGNED(15 downto 0);
  signal DIFF_0: SIGNED(15 downto 0);
  signal DIFF_1: SIGNED(15 downto 0);
  signal DIFF_2: SIGNED(15 downto 0);
  signal DIFF_3: SIGNED(15 downto 0);
  signal DIFF_4: SIGNED(15 downto 0);
  signal DIFF_5: SIGNED(15 downto 0);
  signal DIFF_6: SIGNED(15 downto 0);
  signal DIFF_7: SIGNED(15 downto 0);

begin

  uut: bp_subtract_block port map ( BASE_0 => BASE_0,
                                    SUB_0  => SUB_0,
                                    BASE_1 => BASE_1,
                                    SUB_1  => SUB_1,
                                    BASE_2 => BASE_2,
                                    SUB_2  => SUB_2,
                                    BASE_3 => BASE_3,
                                    SUB_3  => SUB_3,
                                    BASE_4 => BASE_4,
                                    SUB_4  => SUB_4,
                                    BASE_5 => BASE_5,
                                    SUB_5  => SUB_5,
                                    BASE_6 => BASE_6,
                                    SUB_6  => SUB_6,
                                    BASE_7 => BASE_7,
                                    SUB_7  => SUB_7,
                                    DIFF_0 => DIFF_0,
                                    DIFF_1 => DIFF_1,
                                    DIFF_2 => DIFF_2,
                                    DIFF_3 => DIFF_3,
                                    DIFF_4 => DIFF_4,
                                    DIFF_5 => DIFF_5,
                                    DIFF_6 => DIFF_6,
                                    DIFF_7 => DIFF_7 );

  stimulus: process begin
    BASE_0 <= x"3000";
    SUB_0 <= x"2000";
    wait for 10 ns;
    BASE_0 <= x"1000";
    SUB_0 <= x"F000";
    wait for 10 ns;
    BASE_0 <= x"F000";
    SUB_0 <= x"E000";
    wait for 10 ns;
    BASE_0 <= x"3000";
    SUB_0 <= x"4000";
    wait for 10 ns;
    BASE_0 <= x"B000";
    SUB_0 <= x"A000";
    wait for 10 ns;
  end process;


end;
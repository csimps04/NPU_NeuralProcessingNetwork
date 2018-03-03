library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bp_multiply_block_tb is
end;

architecture bench of bp_multiply_block_tb is

  component bp_multiply_block Port (
              D_IN0 : IN SIGNED(15 downto 0);
              D_IN1 : IN SIGNED(15 downto 0);
              D_OUT : OUT SIGNED(15 downto 0));
  end component;

  signal D_IN0: SIGNED(15 downto 0);
  signal D_IN1: SIGNED(15 downto 0);
  signal D_OUT: SIGNED(15 downto 0);

begin

  uut: bp_multiply_block port map ( D_IN0 => D_IN0,
                                    D_IN1 => D_IN1,
                                    D_OUT => D_OUT );

  stimulus: process begin
    D_IN0 <= x"1000";
    D_IN1 <= x"2800";
    wait;
  end process;


end;
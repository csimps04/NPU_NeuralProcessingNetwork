library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bp_deriv_block_tb is
end;

architecture bench of bp_deriv_block_tb is

  component bp_deriv_block Port (
              D_IN : IN SIGNED(15 downto 0);
              D_OUT : OUT SIGNED(15 downto 0));
  end component;

  signal D_IN: SIGNED(15 downto 0);
  signal D_OUT: SIGNED(15 downto 0);

begin

  uut: bp_deriv_block port map ( D_IN  => D_IN,
                                 D_OUT => D_OUT );

  stimulus: process begin
    wait for 10 ns;
    D_IN <= x"0000";
    wait for 10 ns;
    D_IN <= x"0200";
    wait for 10 ns;
    D_IN <= x"0400";
    wait for 10 ns;
    D_IN <= x"0600";
    wait for 10 ns;
    D_IN <= x"0800";
    wait for 10 ns;
    D_IN <= x"0A00";
    wait for 10 ns;
    D_IN <= x"0C00";
    wait for 10 ns;
    D_IN <= x"0E00";
    wait for 10 ns;
    D_IN <= x"1000";
  end process;


end;
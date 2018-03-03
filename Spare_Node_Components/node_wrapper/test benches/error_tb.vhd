library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bp_error_block_tb is
end;

architecture bench of bp_error_block_tb is

  component bp_error_block Port (
              SUM: IN SIGNED(31 downto 0);
              O_VAL : IN SIGNED(15 downto 0);
              ERR : OUT SIGNED(15 downto 0));
  end component;

  signal SUM: SIGNED(31 downto 0);
  signal O_VAL: SIGNED(15 downto 0);
  signal ERR: SIGNED(15 downto 0);

begin

  uut: bp_error_block port map ( SUM   => SUM,
                                 O_VAL => O_VAL,
                                 ERR   => ERR );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
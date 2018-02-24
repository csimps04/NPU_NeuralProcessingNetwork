library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bp_multiply_block is Port (
      MODE: IN STD_LOGIC;
      SUM: IN SIGNED(35 downto 0);
      O_VAL : IN SIGNED(15 downto 0);
      ERR : OUT SIGNED(15 downto 0);
end bp_multiply_block;

architecture Behavioral of bp_multiply_block is

begin

end Behavioral;






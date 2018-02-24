library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bp_error_block is Port (
            SUM: IN SIGNED(31 downto 0);
            O_VAL : IN SIGNED(15 downto 0);
            ERR : OUT SIGNED(15 downto 0));
end bp_error_block;

architecture Behavioral of bp_error_block is

SIGNAL product : SIGNED(47 downto 0);
SIGNAL product_trunc : SIGNED(15 downto 0);
begin

product <= SUM * O_VAL;
product_trunc <= product(47 downto 32);
ERR <= product_trunc;

end Behavioral;

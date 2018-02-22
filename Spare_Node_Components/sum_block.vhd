library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sum_block is Port (
                            val0: IN SIGNED(31 downto 0);
                            val1: IN SIGNED(31 downto 0);
                            val2: IN SIGNED(31 downto 0);
                            val3: IN SIGNED(31 downto 0);
                            val4: IN SIGNED(31 downto 0);
                            val5: IN SIGNED(31 downto 0);
                            val6: IN SIGNED(31 downto 0);
                            val7: IN SIGNED(31 downto 0);
                            sum: OUT SIGNED(35 downto 0));
end sum_block;

architecture Behavioral of sum_block is

SIGNAL sum01 : SIGNED(35 downto 0);
SIGNAL sum23 : SIGNED(35 downto 0);
SIGNAL sum45 : SIGNED(35 downto 0);
SIGNAL sum67 : SIGNED(35 downto 0);

SIGNAL sum1234: SIGNED(35 downto 0);
SIGNAL sum4567: SIGNED(35 downto 0);

begin

sum01 <= resize(val0, 36) + resize(val1, 36);
sum23 <= resize(val2, 36) + resize(val3, 36);
sum45 <= resize(val4, 36) + resize(val5, 36);
sum67 <= resize(val6, 36) + resize(val7, 36);

sum1234 <= sum01 + sum23;
sum4567 <= sum45 + sum67;

sum <= sum1234 + sum4567;


end Behavioral;

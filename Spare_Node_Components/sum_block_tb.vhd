library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sum_block_tb is
--  Port ( );
end sum_block_tb;

architecture Behavioral of sum_block_tb is

component sum_block is Port (
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

SIGNAL v0: SIGNED(31 downto 0);
SIGNAL v1: SIGNED(31 downto 0);
SIGNAL v2: SIGNED(31 downto 0);
SIGNAL v3: SIGNED(31 downto 0);
SIGNAL v4: SIGNED(31 downto 0);
SIGNAL v5: SIGNED(31 downto 0);
SIGNAL v6: SIGNED(31 downto 0);
SIGNAL v7: SIGNED(31 downto 0);
SIGNAL sum_sig : SIGNED(35 downto 0);

begin

uut : sum_block PORT MAP(val0 => v0,val1 => v1, val2 => v2, val3 => v3, val4 => v4, val5 => v5, val6 => v6, val7 => v7, sum => sum_sig);

test : process begin

wait for 10 ns;
v0 <= x"00000001";
v1 <= x"00000001";
v2 <= x"00000000";
v3 <= x"00000000";
v4 <= x"00000000";
v5 <= x"00000000";
v6 <= x"00000000";
v7 <= x"00000000";
wait for 10 ns;
v0 <= x"00000001";
v1 <= x"FFFFFFFF";
v2 <= x"00000000";
v3 <= x"00000000";
v4 <= x"00000000";
v5 <= x"00000000";
v6 <= x"00000000";
v7 <= x"00000000";
wait for 10 ns;
v0 <= x"78000000";
v1 <= x"78000000";
v2 <= x"78000000";
v3 <= x"78000000";
v4 <= x"78000000";
v5 <= x"78000000";
v6 <= x"78000000";
v7 <= x"78000000";

end process test;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bp_subtract_block is Port (
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
end bp_subtract_block;

architecture Behavioral of bp_subtract_block is

begin

DIFF_0 <= BASE_0 - SUB_0;
DIFF_1 <= BASE_1 - SUB_1;
DIFF_2 <= BASE_2 - SUB_2;
DIFF_3 <= BASE_3 - SUB_3;
DIFF_4 <= BASE_4 - SUB_4;
DIFF_5 <= BASE_5 - SUB_5;
DIFF_6 <= BASE_6 - SUB_6;
DIFF_7 <= BASE_7 - SUB_7;

end Behavioral;

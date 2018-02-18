library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--input is signed fixed point between -8 and 8
--output is signed fixed point between 0 and 1
entity sigmoid is Port ( DIN : IN STD_LOGIC_VECTOR (15 downto 0);
                         DOUT : OUT STD_LOGIC_VECTOR (15 downto 0));
end sigmoid;

architecture Behavioral of sigmoid is

SIGNAL S1_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL S2_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL S3_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";

SIGNAL R1_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R2_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R3_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R4_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R5_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R6_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
SIGNAL R7_SIG : STD_LOGIC_VECTOR (15 downto 0) := x"0000"; 

begin
S1_SIG <= DIN(15) & DIN(15) & DIN(15 downto 2);
S2_SIG <= DIN(15) & DIN(15) & DIN(15) & DIN(15 downto 3);
S3_SIG <= DIN(15) & DIN(15) & DIN(15) & DIN(15) & DIN(15) & DIN(15 downto 5);

R1_SIG <= x"0800" + S1_SIG;
R2_SIG <= x"0A00" + S2_SIG;
R3_SIG <= x"0D80" + S3_SIG;
R4_SIG <= x"1000";
R5_SIG <= x"0000";
R6_SIG <= x"0280" + S3_SIG;
R7_SIG <= x"0600" + S2_SIG;
process begin

if DIN < x"1000" then
  DOUT <= R1_SIG;
elsif DIN < x"2600" then
  DOUT <= R2_SIG;
elsif DIN < x"5000" then
  DOUT <= R3_SIG;
elsif DIN < x"8000" then
  DOUT <= R4_SIG;
elsif DIN < x"B000" then
  DOUT <= R5_SIG;
elsif DIN < x"DA00" then
  DOUT <= R6_SIG;
elsif DIN < x"F000" then
    DOUT <= R7_SIG;
else
  DOUT <= R1_SIG;
end if;

end process;

end Behavioral;



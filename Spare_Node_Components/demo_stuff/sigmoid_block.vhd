library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--this piece of hardware computes the sigmoid function approximation for the output

entity sigmoid_block is Port (
                                input : IN SIGNED(35 downto 0);
                                sigmoid: OUT SIGNED(15 downto 0));
end sigmoid_block;

architecture Behavioral of sigmoid_block is

SIGNAL sign : SIGNED(35 downto 0);
SIGNAL sign_trunc : SIGNED(15 downto 0);

SIGNAL shift0 : SIGNED(15 downto 0);
SIGNAL shift1 : SIGNED(15 downto 0);
SIGNAL shift2 : SIGNED(15 downto 0);

SIGNAL region0 : SIGNED(15 downto 0);
SIGNAL region1 : SIGNED(15 downto 0);
SIGNAL region2 : SIGNED(15 downto 0);
SIGNAL region3 : SIGNED(15 downto 0);
SIGNAL region4 : SIGNED(15 downto 0);
SIGNAL region5 : SIGNED(15 downto 0);
SIGNAL region6 : SIGNED(15 downto 0);

SIGNAL out_sig : SIGNED(15 downto 0);

begin

sign <= signed(input(35 downto 0));
sign_trunc <= signed(input(35) & input(26 downto 12));

--computes shifted values for the different linear regions
shift0 <= shift_right(sign_trunc, 2);
shift1 <= shift_right(sign_trunc, 3);
shift2 <= shift_right(sign_trunc, 5);

--adds offsets to the shifted values to determine the regions' output values
region0 <= x"0800" + shift0;
region1 <= x"0A00" + shift1;
region2 <= x"0D80" + shift2;
region3 <= x"1000";
region4 <= x"0000";
region5 <= x"0280" + shift2;
region6 <= x"0600" + shift1;

sigmoid <= out_sig;

--this process uses comparisons to determine which linear region a input is in
process (input, sign, sign_trunc, shift0, shift1, shift2, region0, region1, region2, region3, region4, region5, region6)
begin
    if sign > x"FFF000000" and sign < x"001000000" then
        out_sig <= region0;
    elsif sign >= x"001000000" and sign < x"002600000" then
        out_sig <= region1;
    elsif sign >= x"002600000" and sign < x"005000000" then
        out_sig <= region2;
    elsif sign >= x"005000000" then
        out_sig <= region3;
    elsif sign <= x"FFB000000" then
        out_sig <= region4;
    elsif sign <= x"FFDA00000" then
        out_sig <= region5;
    elsif sign <= x"FFF000000" then
        out_sig <= region6;
    else 
        out_sig <= region4;
    end if;
end process;

end Behavioral;

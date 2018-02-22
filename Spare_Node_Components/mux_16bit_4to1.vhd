library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_16bit_4to1 is Port (
            SEL : IN STD_LOGIC_VECTOR(1 downto 0);
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
            D_IN2 : IN SIGNED(15 downto 0);
            D_IN3 : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end mux_16bit_4to1;

architecture Behavioral of mux_16bit_4to1 is

begin

process (SEL, D_IN0, D_IN1 ,D_IN2, D_IN3) begin
    case SEL is
    when "00" => D_OUT <= D_IN0;
    when "01" =>  D_OUT <= D_IN1;
    when "10" =>  D_OUT <= D_IN2;
    when "11" =>  D_OUT <= D_IN3;
    when others =>  D_OUT <= x"0000";
    end case;
end process;

end Behavioral;

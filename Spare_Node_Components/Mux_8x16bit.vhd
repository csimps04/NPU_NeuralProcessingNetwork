----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2018 06:08:57 PM
-- Design Name: 
-- Module Name: 16to1Mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity a16to1Mux is
    Port ( 
            d_in0   :   in  std_logic_vector(15 downto 0);
            d_in1   :   in  std_logic_vector(15 downto 0);
            d_in2   :   in  std_logic_vector(15 downto 0);
            d_in3   :   in  std_logic_vector(15 downto 0);    
            d_in4   :   in  std_logic_vector(15 downto 0);
            d_in5   :   in  std_logic_vector(15 downto 0);
            d_in6   :   in  std_logic_vector(15 downto 0);
            d_in7   :   in  std_logic_vector(15 downto 0);
            sel     :   in  std_logic_vector(2 downto 0);
            d_out   :   out  std_logic_vector(15 downto 0)                           
    );
end a16to1Mux;

architecture Behavioral of a16to1Mux is
begin

multiplex   :   process (sel)
begin
    case sel is
    when "000" =>  d_out <= d_in0;
    when "001" =>  d_out <= d_in1;
    when "010" =>  d_out <= d_in2;
    when "011" =>  d_out <= d_in3;
    when "100" =>  d_out <= d_in4;
    when "101" =>  d_out <= d_in5;
    when "110" =>  d_out <= d_in6;
    when "111" =>  d_out <= d_in7;
    when others =>  d_out <= x"0000";
    end case;

end process multiplex;

end Behavioral;

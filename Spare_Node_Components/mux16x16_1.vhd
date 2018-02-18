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
            d_in8   :   in  std_logic_vector(15 downto 0); 
            d_in9   :   in  std_logic_vector(15 downto 0);
            d_in10  :   in  std_logic_vector(15 downto 0);
            d_in11  :   in  std_logic_vector(15 downto 0);
            d_in12  :   in  std_logic_vector(15 downto 0);
            d_in13  :   in  std_logic_vector(15 downto 0);
            d_in14  :   in  std_logic_vector(15 downto 0);
            d_in15  :   in  std_logic_vector(15 downto 0);
            sel     :   in  std_logic_vector(3 downto 0);
            d_out   :   out  std_logic_vector(15 downto 0)                           
    );
end a16to1Mux;

architecture Behavioral of a16to1Mux is
begin

multiplex   :   process (sel)
begin
    case sel is
    when "0000" =>  d_out <= d_in0;
    when "0001" =>  d_out <= d_in1;
    when "0010" =>  d_out <= d_in2;
    when "0011" =>  d_out <= d_in3;
    when "0100" =>  d_out <= d_in4;
    when "0101" =>  d_out <= d_in5;
    when "0110" =>  d_out <= d_in6;
    when "0111" =>  d_out <= d_in7;
    when "1000" =>  d_out <= d_in8;
    when "1001" =>  d_out <= d_in9;
    when "1010" =>  d_out <= d_in10;
    when "1011" =>  d_out <= d_in11;    
    when "1100" =>  d_out <= d_in12;    
    when "1101" =>  d_out <= d_in13;
    when "1110" =>  d_out <= d_in14;
    when "1111" =>  d_out <= d_in15;
    when others =>  d_out <= x"0000";
    end case;

end process multiplex;

end Behavioral;

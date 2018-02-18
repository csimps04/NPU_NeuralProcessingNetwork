----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2018 03:36:51 PM
-- Design Name: 
-- Module Name: weight_node_reg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_16bit is
    Port (
                CLK         :   in  std_logic;
                WE          :   in  std_logic;
                CLR         :   in  std_logic;
                d_in        :   in  std_logic_vector(15 downto 0);
                d_out       :   out std_logic_vector(15 downto 0)
     );
end reg_16bit;

architecture Behavioral of reg_16bit is
signal layer_output : std_logic_vector(15 downto 0) := x"0000";
begin

    main : process (WE, CLR, CLK)
    begin
        if(rising_edge(CLK)) then
            if CLR = '1' then
                layer_output <= (others => '0');
            elsif WE = '1' then
                layer_output <= d_in;
            end if;               
        end if;
        

    end process main;

d_out <= layer_output;

end Behavioral;
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

entity weight_node_reg is
    Generic (
                ADDR_SZE    :   integer :=  3;   
                LAYER_SZE   :   integer :=  8
    );

    Port (
                CLK         :   in  std_logic;
                WE          :   in  std_logic;
                CLR         :   in  std_logic;
                d_in        :   in  std_logic_vector(15 downto 0);
                l_sel       :   in  std_logic_vector(ADDR_SZE - 1 downto 0);
                d_out       :   out std_logic_vector(15 downto 0)
     );
end weight_node_reg;

architecture Behavioral of weight_node_reg is
    TYPE mem is array(0 to LAYER_SZE - 1) of std_logic_vector(15 downto 0);
    signal node_weights : mem := (others => (others => '0'));
begin

    main : process (WE, CLR, CLK)
    begin
        if(rising_edge(CLK)) then
            if CLR = '1' then
                node_weights <= (others => (others => '0'));
            elsif WE = '1' then
                node_weights(conv_integer(l_sel)) <= d_in;
            end if;
            
             
        end if;
  
    end process main;
    
    d_out <= node_weights(conv_integer(l_sel));

end Behavioral;

----------------------------------------------------------------------------------
-- Company: NPU
-- Engineer: Cameron Simpson
-- 
-- Create Date: 02/08/2018 03:18:01 PM
-- Design Name: 
-- Module Name: weight_cache - Behavioral
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
--  Upon WE signal, the weights will update on same cycle.
--  This may cause issues for backprop process
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity weight_cache is
    Generic (
            ND_ADDR_SZE :   integer :=  4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  10
    );

    Port (
            clk         :   in  std_logic;
            WE          :   in  std_logic;
            reset       :   in  std_logic;
            data_in     :   in  signed(15 downto 0);
            layer_sel   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
            nd_sel      :   in  std_logic_vector(ND_ADDR_SZE - 1 downto 0);
            wt_out_0    :   out signed(15 downto 0);
            wt_out_1    :   out signed(15 downto 0);
            wt_out_2    :   out signed(15 downto 0);
            wt_out_3    :   out signed(15 downto 0);
            wt_out_4    :   out signed(15 downto 0);
            wt_out_5    :   out signed(15 downto 0);
            wt_out_6    :   out signed(15 downto 0);
            wt_out_7    :   out signed(15 downto 0)
     );
end weight_cache;

architecture Behavioral of weight_cache is

component weight_node_reg is
    Port (
            CLK         :   in  std_logic;
            WE          :   in  std_logic;
            CLR         :   in  std_logic;
            d_in        :   in  signed(15 downto 0);
            l_sel       :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
            d_out       :   out signed(15 downto 0)
     );
end component;


signal      S_LAYER_SSEL     :   std_logic_vector(LY_ADDR_SZE - 1 downto 0) := "000";
signal      S_WE_EN          :   std_logic_vector(LAYER_SZE - 1 downto 0) := (others => '0');


begin

node0 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(0),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_0);

node1 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(1),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_1);

node2 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(2),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_2);                                
                
node3 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(3),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_3);

node4 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(4),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_4);
                
node5 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(5),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_5);                

node6 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(6),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_6);                

node7 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   S_WE_EN(7),
                CLR         =>   reset,
                d_in        =>   data_in,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_7);                


                
-- mux 
node_write_sel  :   process (WE, nd_sel)
begin
    S_WE_EN <= "0000000000";

    S_WE_EN(conv_integer(nd_sel)) <= WE;
    
--    case nd_sel is
--        when "0000"     =>      S_WE_EN(0)     <=   WE;
--        when "0001"     =>      S_WE_EN(1)     <=   WE;
--        when "0010"     =>      S_WE_EN(2)     <=   WE;
--        when "0011"     =>      S_WE_EN(3)     <=   WE;
--        when "0100"     =>      S_WE_EN(4)     <=   WE;
--        when "0101"     =>      S_WE_EN(5)     <=   WE;
--        when "0110"     =>      S_WE_EN(6)     <=   WE;
--        when "0111"     =>      S_WE_EN(7)     <=   WE;
--        when "1000"     =>      S_WE_EN(8)     <=   WE;
--        when "1001"     =>      S_WE_EN(9)     <=   WE;
--        --when "1010"     =>      S_WE_EN(10)    <=   WE;
--        --when "1011"     =>      S_WE_EN(11)    <=   WE;
--        --when "1100"     =>      S_WE_EN(12)    <=   WE;
--        --when "1101"     =>      S_WE_EN(13)    <=   WE;
--        --when "1110"     =>      S_WE_EN(14)    <=   WE;
--        --when "1111"     =>      S_WE_EN(15)    <=   WE;
--        when others     =>      S_WE_EN        <=   "0000000000";        
--    end case;      
                                
        

end process node_write_sel;

end Behavioral;

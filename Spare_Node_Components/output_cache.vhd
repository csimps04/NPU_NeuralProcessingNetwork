----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2018 03:26:46 PM
-- Design Name: 
-- Module Name: output_cache - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity output_cache is
    Generic (
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8
    );
    Port ( 
                CLK         :   in  std_logic;
                WE          :   in  std_logic;
                CLR         :   in  std_logic;
                l_sel       :   in std_logic_vector(LY_ADDR_SZE - 1 downto 0);
                d_in        :   in  std_logic_vector(15 downto 0);
                d_out       :   out std_logic_vector(15 downto 0)
    );
end output_cache;

architecture Behavioral of output_cache is

component reg_16bit is
    Port (
                CLK         :   in  std_logic;
                WE          :   in  std_logic;
                CLR         :   in  std_logic;
                d_in        :   in  std_logic_vector(15 downto 0);
                d_out       :   out std_logic_vector(15 downto 0)
     );
end component;

type out_bus is array(0 to LAYER_SZE - 1) of std_logic_vector(15 downto 0);
signal  S_D_OUT : out_bus := (others => (others => '0'));

signal S_WE_EN : std_logic_vector(LAYER_SZE -1 downto 0) := "00000000";
--signal S_D_OUT0 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT1 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT2 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT3 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT4 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT5 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT6 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT7 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT8 : std_logic_vector(16 downto 0) := x"0000";
--signal S_D_OUT9 : std_logic_vector(16 downto 0) := x"0000";

begin

out0 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(0),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(0)      
     );

out1 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(1),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(1)      
     );

out2 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(2),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(2)      
     );     

out3 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(3),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(3)      
     );

out4 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(4),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(4)      
     );

out5 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(5),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(5)      
     );

out6 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(6),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(6)      
     );

out7 : reg_16bit
    Port Map(
                CLK         =>      CLK,
                WE          =>      S_WE_EN(7),
                CLR         =>      CLR,
                d_in        =>      d_in,
                d_out       =>      S_D_OUT(7)      
     );


output_layer : process(WE, CLK, S_D_OUT)
begin

    S_WE_EN <= (others => '0');
    S_WE_EN(conv_integer(l_sel)) <= WE;
    d_out <= S_D_OUT(conv_integer(l_sel));

end process output_layer;


end Behavioral;

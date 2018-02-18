----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2018 07:36:18 PM
-- Design Name: 
-- Module Name: multiply_block - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity multiply_block is
    Port ( 
            m_cand0     :   in  std_logic_vector(15 downto 0);
            m_plier0    :   in  std_logic_vector(15 downto 0);    
            m_cand1     :   in  std_logic_vector(15 downto 0);
            m_plier1    :   in  std_logic_vector(15 downto 0);
            m_cand2     :   in  std_logic_vector(15 downto 0);
            m_plier2    :   in  std_logic_vector(15 downto 0);
            m_cand3     :   in  std_logic_vector(15 downto 0);
            m_plier3    :   in  std_logic_vector(15 downto 0);                
            m_cand4     :   in  std_logic_vector(15 downto 0);
            m_plier4    :   in  std_logic_vector(15 downto 0);
            m_cand5     :   in  std_logic_vector(15 downto 0);
            m_plier5    :   in  std_logic_vector(15 downto 0);
            m_cand6     :   in  std_logic_vector(15 downto 0);
            m_plier6    :   in  std_logic_vector(15 downto 0);
            m_cand7     :   in  std_logic_vector(15 downto 0);
            m_plier7    :   in  std_logic_vector(15 downto 0);
            product0    :   out std_logic_vector(31 downto 0);
            product1    :   out std_logic_vector(31 downto 0);
            product2    :   out std_logic_vector(31 downto 0);
            product3    :   out std_logic_vector(31 downto 0);
            product4    :   out std_logic_vector(31 downto 0);
            product5    :   out std_logic_vector(31 downto 0);
            product6    :   out std_logic_vector(31 downto 0);
            product7    :   out std_logic_vector(31 downto 0)
    );
end multiply_block;

architecture Behavioral of multiply_block is

begin

    product0 <=     std_logic_vector(signed(m_cand0) * signed(m_plier0));
    product1 <=     std_logic_vector(signed(m_cand1) * signed(m_plier1));
    product2 <=     std_logic_vector(signed(m_cand2) * signed(m_plier2));
    product3 <=     std_logic_vector(signed(m_cand3) * signed(m_plier3));
    product4 <=     std_logic_vector(signed(m_cand4) * signed(m_plier4));
    product5 <=     std_logic_vector(signed(m_cand5) * signed(m_plier5));
    product6 <=     std_logic_vector(signed(m_cand6) * signed(m_plier6));
    product7 <=     std_logic_vector(signed(m_cand7) * signed(m_plier7));


end Behavioral;

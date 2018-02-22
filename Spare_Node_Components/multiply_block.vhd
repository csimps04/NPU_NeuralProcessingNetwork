library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiply_block is
    Port ( 
            m_cand0     :   IN SIGNED(15 downto 0);
            m_plier0    :   IN SIGNED(15 downto 0);    
            m_cand1     :   IN SIGNED(15 downto 0);
            m_plier1    :   IN SIGNED(15 downto 0);
            m_cand2     :   IN SIGNED(15 downto 0);
            m_plier2    :   IN SIGNED(15 downto 0);
            m_cand3     :   IN SIGNED(15 downto 0);
            m_plier3    :   IN SIGNED(15 downto 0);                
            m_cand4     :   IN SIGNED(15 downto 0);
            m_plier4    :   IN SIGNED(15 downto 0);
            m_cand5     :   IN SIGNED(15 downto 0);
            m_plier5    :   IN SIGNED(15 downto 0);
            m_cand6     :   IN SIGNED(15 downto 0);
            m_plier6    :   IN SIGNED(15 downto 0);
            m_cand7     :   IN SIGNED(15 downto 0);
            m_plier7    :   IN SIGNED(15 downto 0);
            product0    :   OUT SIGNED(31 downto 0);
            product1    :   OUT SIGNED(31 downto 0);
            product2    :   OUT SIGNED(31 downto 0);
            product3    :   OUT SIGNED(31 downto 0);
            product4    :   OUT SIGNED(31 downto 0);
            product5    :   OUT SIGNED(31 downto 0);
            product6    :   OUT SIGNED(31 downto 0);
            product7    :   OUT SIGNED(31 downto 0)
    );
end multiply_block;

architecture Behavioral of multiply_block is

begin

    product0 <= m_cand0 * m_plier0;
    product1 <= m_cand1 * m_plier1;
    product2 <= m_cand2 * m_plier2;
    product3 <= m_cand3 * m_plier3;
    product4 <= m_cand4 * m_plier4;
    product5 <= m_cand5 * m_plier5;
    product6 <= m_cand6 * m_plier6;
    product7 <= m_cand7 * m_plier7;


end Behavioral;

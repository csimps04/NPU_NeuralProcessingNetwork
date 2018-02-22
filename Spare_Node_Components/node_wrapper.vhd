library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity node_wrapper is Port (
            IN_0 : IN SIGNED(15 downto 0);
            IN_1 : IN SIGNED(15 downto 0);
            IN_2 : IN SIGNED(15 downto 0);
            IN_3 : IN SIGNED(15 downto 0);
            IN_4 : IN SIGNED(15 downto 0);
            IN_5 : IN SIGNED(15 downto 0);
            IN_6 : IN SIGNED(15 downto 0);
            IN_7 : IN SIGNED(15 downto 0);
            W_0 : IN SIGNED(15 downto 0);
            W_1 : IN SIGNED(15 downto 0);
            W_2 : IN SIGNED(15 downto 0);
            W_3 : IN SIGNED(15 downto 0);
            W_4 : IN SIGNED(15 downto 0);
            W_5 : IN SIGNED(15 downto 0);
            W_6 : IN SIGNED(15 downto 0);
            W_7 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0));
end node_wrapper;

architecture Behavioral of node_wrapper is

component multiply_block is Port ( 
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
            product7    :   OUT SIGNED(31 downto 0));
end component;

component sum_block is Port (
            val0: IN SIGNED(31 downto 0);
            val1: IN SIGNED(31 downto 0);
            val2: IN SIGNED(31 downto 0);
            val3: IN SIGNED(31 downto 0);
            val4: IN SIGNED(31 downto 0);
            val5: IN SIGNED(31 downto 0);
            val6: IN SIGNED(31 downto 0);
            val7: IN SIGNED(31 downto 0);
            sum: OUT SIGNED(35 downto 0));
end component;

component shift_block is Port (
                D_IN : IN SIGNED(35 downto 0);
                SHIFT : IN UNSIGNED(2 downto 0);
                D_OUT : OUT SIGNED(35 downto 0));
end component;

component sigmoid_block is Port (
            input : IN SIGNED(35 downto 0);
            sigmoid: OUT SIGNED(15 downto 0));
end component;

component mux_16bit_4to1 is Port (
            SEL : IN STD_LOGIC_VECTOR(1 downto 0);
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
            D_IN2 : IN SIGNED(15 downto 0);
            D_IN3 : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end component;

SIGNAL product0_sig : SIGNED(31 downto 0);
SIGNAL product1_sig : SIGNED(31 downto 0);
SIGNAL product2_sig : SIGNED(31 downto 0);
SIGNAL product3_sig : SIGNED(31 downto 0);
SIGNAL product4_sig : SIGNED(31 downto 0);
SIGNAL product5_sig : SIGNED(31 downto 0);
SIGNAL product6_sig : SIGNED(31 downto 0);
SIGNAL product7_sig : SIGNED(31 downto 0);

SIGNAL sum_sig : SIGNED(35 downto 0);
SIGNAL shift_sig : SIGNED(35 downto 0);
SIGNAL sigmoid_sig : SIGNED(15 downto 0);
SIGNAL output_sig : SIGNED(15 downto 0);

begin

mult : multiply_block Port Map (
            m_cand0 => IN_0,
            m_plier0 => W_0,
            m_cand1 => IN_1,
            m_plier1 => W_1,
            m_cand2 => IN_2,
            m_plier2 => W_2,
            m_cand3 => IN_3,
            m_plier3 => W_3,
            m_cand4 => IN_4,
            m_plier4 => W_4,
            m_cand5 => IN_5,
            m_plier5 => W_5,
            m_cand6 => IN_6,
            m_plier6 => W_6,
            m_cand7 => IN_7,
            m_plier7 => W_7,
            product0 => product0_sig,
            product1 => product1_sig,
            product2 => product2_sig,
            product3 => product3_sig,
            product4 => product4_sig,
            product5 => product5_sig,
            product6 => product6_sig,
            product7 => product7_sig
);

sum : sum_block Port Map (
            val0 => product0_sig,
            val1 => product1_sig,
            val2 => product2_sig,
            val3 => product3_sig,
            val4 => product4_sig,
            val5 => product5_sig,
            val6 => product6_sig,
            val7 => product7_sig,
            sum => sum_sig
);

shift : shift_block Port Map (
            D_IN => sum_sig,
            SHIFT => "000",
            D_OUT => shift_sig
);

sigmoid : sigmoid_block Port Map (
            input => shift_sig,
            sigmoid => sigmoid_sig 
);

mux : mux_16bit_4to1 Port Map (
           SEL => "00",
           D_IN0 => sigmoid_sig,
           D_IN1 => x"0000",
           D_IN2 => x"0000",
           D_IN3 => x"0000",
           D_OUT => output_sig
);

OUT_0 <= output_sig;

end Behavioral;

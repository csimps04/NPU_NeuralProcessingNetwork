library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--the node computation block performs mathematical calculations necessary to neural network operation

entity node_compute_block is Port (
            MODE : IN STD_LOGIC_VECTOR(1 downto 0);
            IN_0 : IN SIGNED(15 downto 0);
            IN_1 : IN SIGNED(15 downto 0);
            IN_2 : IN SIGNED(15 downto 0);
            IN_3 : IN SIGNED(15 downto 0);
            IN_4 : IN SIGNED(15 downto 0);
            IN_5 : IN SIGNED(15 downto 0);
            IN_6 : IN SIGNED(15 downto 0);
            IN_7 : IN SIGNED(15 downto 0);
            WIN_0 : IN SIGNED(15 downto 0);
            WIN_1 : IN SIGNED(15 downto 0);
            WIN_2 : IN SIGNED(15 downto 0);
            WIN_3 : IN SIGNED(15 downto 0);
            WIN_4 : IN SIGNED(15 downto 0);
            WIN_5 : IN SIGNED(15 downto 0);
            WIN_6 : IN SIGNED(15 downto 0);
            WIN_7 : IN SIGNED(15 downto 0);
            BPIN_0 : IN SIGNED(15 downto 0);
            BPIN_1 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0);
            OUT_1 : OUT SIGNED(15 downto 0);
            OUT_2 : OUT SIGNED(15 downto 0);
            OUT_3 : OUT SIGNED(15 downto 0);
            OUT_4 : OUT SIGNED(15 downto 0);
            OUT_5 : OUT SIGNED(15 downto 0);
            OUT_6 : OUT SIGNED(15 downto 0);
            OUT_7 : OUT SIGNED(15 downto 0));
end node_compute_block;

architecture Behavioral of node_compute_block is

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

component sigmoid_block is Port (
            input : IN SIGNED(35 downto 0);
            sigmoid: OUT SIGNED(15 downto 0));
end component;

component bp_deriv_block is Port (
            D_IN : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end component;

component bp_multiply_block is Port (
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end component;

component bp_error_block is Port (
            SUM: IN SIGNED(31 downto 0);
            O_VAL : IN SIGNED(15 downto 0);
            ERR : OUT SIGNED(15 downto 0));
end component;

component bp_subtract_block is Port (
            BASE_0 :IN SIGNED(15 downto 0);
            SUB_0 : IN SIGNED(15 downto 0);
            BASE_1 :IN SIGNED(15 downto 0);
            SUB_1 : IN SIGNED(15 downto 0);
            BASE_2 :IN SIGNED(15 downto 0);
            SUB_2 : IN SIGNED(15 downto 0);
            BASE_3 :IN SIGNED(15 downto 0);
            SUB_3 : IN SIGNED(15 downto 0);
            BASE_4 :IN SIGNED(15 downto 0);
            SUB_4 : IN SIGNED(15 downto 0);
            BASE_5 :IN SIGNED(15 downto 0);
            SUB_5 : IN SIGNED(15 downto 0);
            BASE_6 :IN SIGNED(15 downto 0);
            SUB_6 : IN SIGNED(15 downto 0);
            BASE_7 :IN SIGNED(15 downto 0);
            SUB_7 : IN SIGNED(15 downto 0);
            DIFF_0 : OUT SIGNED(15 downto 0);
            DIFF_1 : OUT SIGNED(15 downto 0);
            DIFF_2 : OUT SIGNED(15 downto 0);
            DIFF_3 : OUT SIGNED(15 downto 0);
            DIFF_4 : OUT SIGNED(15 downto 0);
            DIFF_5 : OUT SIGNED(15 downto 0);
            DIFF_6 : OUT SIGNED(15 downto 0);
            DIFF_7 : OUT SIGNED(15 downto 0));
end component;

component mux_16bit_4to1 is Port (
            SEL : IN STD_LOGIC_VECTOR(1 downto 0);
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
            D_IN2 : IN SIGNED(15 downto 0);
            D_IN3 : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end component;

component mux_16bit_2to1 is Port (
            SEL : IN STD_LOGIC;
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
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

SIGNAL product0_trunc_sig : SIGNED(15 downto 0);
SIGNAL product1_trunc_sig : SIGNED(15 downto 0);
SIGNAL product2_trunc_sig : SIGNED(15 downto 0);
SIGNAL product3_trunc_sig : SIGNED(15 downto 0);
SIGNAL product4_trunc_sig : SIGNED(15 downto 0);
SIGNAL product5_trunc_sig : SIGNED(15 downto 0);
SIGNAL product6_trunc_sig : SIGNED(15 downto 0);
SIGNAL product7_trunc_sig : SIGNED(15 downto 0);

SIGNAL diff0_sig : SIGNED(15 downto 0);
SIGNAL diff1_sig : SIGNED(15 downto 0);
SIGNAL diff2_sig : SIGNED(15 downto 0);
SIGNAL diff3_sig : SIGNED(15 downto 0);
SIGNAL diff4_sig : SIGNED(15 downto 0);
SIGNAL diff5_sig : SIGNED(15 downto 0);
SIGNAL diff6_sig : SIGNED(15 downto 0);
SIGNAL diff7_sig : SIGNED(15 downto 0);

SIGNAL sum_sig : SIGNED(35 downto 0);
SIGNAL sigmoid_sig : SIGNED(15 downto 0);
SIGNAL bp_deriv_sig : SIGNED(15 downto 0);
SIGNAL bp_lossfunc_sig : SIGNED(15 downto 0);
SIGNAL bp_mult_in_sig : SIGNED(15 downto 0);
SIGNAL bp_mult_sig : SIGNED(15 downto 0);
SIGNAL bp_error_sig : SIGNED(15 downto 0);

SIGNAL out0_sig : SIGNED(15 downto 0);
SIGNAL out1_sig : SIGNED(15 downto 0);
SIGNAL out2_sig : SIGNED(15 downto 0);
SIGNAL out3_sig : SIGNED(15 downto 0);
SIGNAL out4_sig : SIGNED(15 downto 0);
SIGNAL out5_sig : SIGNED(15 downto 0);
SIGNAL out6_sig : SIGNED(15 downto 0);
SIGNAL out7_sig : SIGNED(15 downto 0);

begin

--handles multiplication of 8 pairs of 16 bit numbers
mult : multiply_block Port Map (
            m_cand0 => IN_0,
            m_plier0 => WIN_0,
            m_cand1 => IN_1,
            m_plier1 => WIN_1,
            m_cand2 => IN_2,
            m_plier2 => WIN_2,
            m_cand3 => IN_3,
            m_plier3 => WIN_3,
            m_cand4 => IN_4,
            m_plier4 => WIN_4,
            m_cand5 => IN_5,
            m_plier5 => WIN_5,
            m_cand6 => IN_6,
            m_plier6 => WIN_6,
            m_cand7 => IN_7,
            m_plier7 => WIN_7,
            product0 => product0_sig,
            product1 => product1_sig,
            product2 => product2_sig,
            product3 => product3_sig,
            product4 => product4_sig,
            product5 => product5_sig,
            product6 => product6_sig,
            product7 => product7_sig
);

--handles summation operation
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

--computes the sigmoid function approximation
sigmoid : sigmoid_block Port Map (
            input => sum_sig,
            sigmoid => sigmoid_sig 
);

--computes the derivative of a sigmoid function value for back propogation
bp_deriv : bp_deriv_block Port Map (
            D_IN => BPIN_0,
            D_OUT => bp_deriv_sig
);

--selects an input for back propagation
bp_mult_mux : mux_16bit_2to1 Port Map (
            SEL => MODE(0),
            D_IN0 => bp_lossfunc_sig,
            D_IN1 => bp_error_sig,
            D_OUT => bp_mult_in_sig
);

--performs a single multiplication necessary for back propagation calculations
bp_mult : bp_multiply_block Port Map (
            D_IN0 => bp_deriv_sig,
            D_IN1 => bp_mult_in_sig,
            D_OUT => bp_mult_sig
);

--computes the error value for the node
bp_error : bp_error_block Port Map (
            SUM => sum_sig(35 downto 4),
            O_VAL => BPIN_1,
            ERR => bp_error_sig
);

--subtraction block for back propagation weight updating
bp_sub : bp_subtract_block Port Map (
            BASE_0 => WIN_0,
            SUB_0 => IN_0,
            BASE_1 => WIN_1,
            SUB_1 => IN_1,
            BASE_2 => WIN_2,
            SUB_2 => IN_2,
            BASE_3 => WIN_3,
            SUB_3 => IN_3,
            BASE_4 => WIN_4,
            SUB_4 => IN_4,
            BASE_5 => WIN_5,
            SUB_5 => IN_5,
            BASE_6 => WIN_6,
            SUB_6 => IN_6,
            BASE_7 => WIN_7,
            SUB_7 => IN_7,
            DIFF_0 => diff0_sig,
            DIFF_1 => diff1_sig,
            DIFF_2 => diff2_sig,
            DIFF_3 => diff3_sig,
            DIFF_4 => diff4_sig,
            DIFF_5 => diff5_sig,
            DIFF_6 => diff6_sig,
            DIFF_7 => diff7_sig
);

--output muxes
mux0 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => sigmoid_sig,
           D_IN1 => x"0000",
           D_IN2 => product0_trunc_sig,
           D_IN3 => diff0_sig,
           D_OUT => out0_sig
);

mux1 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => bp_mult_sig,
           D_IN1 => bp_mult_sig,
           D_IN2 => product1_trunc_sig,
           D_IN3 => diff1_sig,
           D_OUT => out1_sig
);

mux2 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product2_trunc_sig,
           D_IN3 => diff2_sig,
           D_OUT => out2_sig
);

mux3 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product3_trunc_sig,
           D_IN3 => diff3_sig,
           D_OUT => out3_sig
);

mux4 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product4_trunc_sig,
           D_IN3 => diff4_sig,
           D_OUT => out4_sig
);
mux5 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product6_trunc_sig,
           D_IN3 => diff5_sig,
           D_OUT => out5_sig
);
mux6 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product6_trunc_sig,
           D_IN3 => diff6_sig,
           D_OUT => out6_sig
);
mux7 : mux_16bit_4to1 Port Map (
           SEL => MODE,
           D_IN0 => x"0000",
           D_IN1 => x"0000",
           D_IN2 => product7_trunc_sig,
           D_IN3 => diff7_sig,
           D_OUT => out7_sig
);

bp_lossfunc_sig <= BPIN_1 - BPIN_0;

product0_trunc_sig <= product0_sig(31) & product0_sig(26 downto 12);
product1_trunc_sig <= product1_sig(31) & product1_sig(26 downto 12);
product2_trunc_sig <= product2_sig(31) & product2_sig(26 downto 12);
product3_trunc_sig <= product3_sig(31) & product3_sig(26 downto 12);
product4_trunc_sig <= product4_sig(31) & product4_sig(26 downto 12);
product5_trunc_sig <= product5_sig(31) & product5_sig(26 downto 12);
product6_trunc_sig <= product6_sig(31) & product6_sig(26 downto 12);
product7_trunc_sig <= product7_sig(31) & product7_sig(26 downto 12);

OUT_0 <= out0_sig;
OUT_1 <= out1_sig;
OUT_2 <= out2_sig;
OUT_3 <= out3_sig;
OUT_4 <= out4_sig;
OUT_5 <= out5_sig;
OUT_6 <= out6_sig;
OUT_7 <= out7_sig;

end Behavioral;
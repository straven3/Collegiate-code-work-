library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity parityCheck is
    port(
    input1 : in std_logic_vector(3 downto 0); --first input, it will be the left most on the board
    input2 : in std_logic_vector(3 downto 0); -- second input, give it one switch of space???
    singleOut: out std_logic
    );
end parityCheck;

architecture Behavioral of parityCheck is

begin
  singleOut <= (input1(3) xor input1(2) xor input1(1) xor input1(0))
           xor (input2(3) xor input2(2) xor input2(1) xor input2(0));
           --gives one if total number of ones accross both inputs is one

end Behavioral;

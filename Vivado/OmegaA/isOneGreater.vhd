
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity isOneGreater is
port(
    input1 : in std_logic_vector(3 downto 0); --first input, it will be the left most on the board
    input2 : in std_logic_vector(3 downto 0); -- second input, give it one switch of space???
    singleOut: out std_logic
    );
end isOneGreater;

architecture Behavioral of isOneGreater is

begin
     singleOut <= (input1(3) and not input2(3)) or
                     (not (input1(3) xor input2(3)) and input1(2) and not input2(2)) or
                     (not (input1(3) xor input2(3)) and not (input1(2) xor input2(2)) and input1(1) and not input2(1)) or
                     (not (input1(3) xor input2(3)) and not (input1(2) xor input2(2)) and not (input1(1) xor input2(1)) and input1(0) and not input2(0));

end Behavioral;

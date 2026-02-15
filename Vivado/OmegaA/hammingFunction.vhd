

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hammingFunction is
    Port (  input1 : in std_logic_vector(3 downto 0); 
            input2 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0));
end hammingFunction;

architecture Behavioral of hammingFunction is

begin

output(0)<= input1(0) XOR input2(0);
output(1)<= input1(1) XOR input2(1);
output(2)<= input1(2) XOR input2(2);
output(3)<= input1(3) XOR input2(3);

end Behavioral;

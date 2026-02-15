
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
    Port ( A, B, C : in STD_LOGIC;
           Y, Z : out STD_LOGIC);
end fullAdder;

architecture Behavioral of fullAdder is

begin

Y <= (A xor B) xor C;
Z <= (A and B) or (B and C) or (C and A);

end Behavioral;

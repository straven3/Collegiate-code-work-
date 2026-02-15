
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity studio1 is
    port(A : in STD_LOGIC;
    B : in STD_LOGIC;
    C : in STD_LOGIC;
    D : in STD_LOGIC;
    E : out STD_LOGIC;
    F : out STD_LOGIC;
    G : out STD_LOGIC
    );
end studio1;

architecture Behavioral of studio1 is

begin
--checks if AB is greater than CD
-- A AND NOT C only true if A is 1 and C is zero
E<= (A AND (NOT C)) OR ( ((A AND C) OR ((NOT A) AND (NOT C))) AND (B AND (NOT D)) );

--checks if AC is equal to BD (found an equivilent to xor)
F<= ((A AND C) OR ((NOT A) AND (NOT C))) AND ((B AND D) OR ((NOT B) AND (NOT D)));
--checks is E is flase and they are not equal, therefore, AC is less than BD
G<=((NOT A) AND C) OR ( ((A AND C) OR ((NOT A) AND (NOT C))) AND ((NOT B) AND D) );
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Giunta_Colby_Studio_0 is
    Port( A : in STD_LOGIC;
          B : in STD_LOGIC;
          C : out STD_LOGIC);
end Giunta_Colby_Studio_0;

architecture Behavioral of Giunta_Colby_Studio_0 is

begin
C <= A AND B;

end Behavioral;

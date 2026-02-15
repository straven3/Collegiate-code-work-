library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fourBitAdder is
    Port (  input1 : in std_logic_vector(3 downto 0); 
            input2 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(4 downto 0));
end fourBitAdder;

architecture Structural of fourBitAdder is
    component fullAdder is
    Port(   A, B, C : in STD_LOGIC;
            Y, Z : out STD_LOGIC);
    end component fullAdder;

    signal carry : std_logic_vector(3 downto 0);
    
begin
bit1: fullAdder
    port map (
    A => input1(0), 
    B => input2(0), 
    C => '0',
    Y => output(0), 
    Z => carry(0)
    );
bit2: fullAdder
    port map (
    A => input1(1), 
    B => input2(1), 
    C => carry(0),
    Y => output(1), 
    Z => carry(1)
    );
bit3: fullAdder
    port map (
    A => input1(2), 
    B => input2(2), 
    C => carry(1),
    Y => output(2), 
    Z => carry(2)
    );
bit4: fullAdder
    port map (
    A => input1(3), 
    B => input2(3), 
    C => carry(2),
    Y => output(3), 
    Z => output(4)
    );

end Structural;


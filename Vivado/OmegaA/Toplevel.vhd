
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity topLevel is
    Port ( 
            sw: std_logic_vector (15 downto 0);--15 and 14 are alu pins --gives us all the switches as inputs
            
            led: out std_logic_vector(15 downto 0);--led 0 is the closest to the right
            --boilerplate code for getting the displays working
            clk: in std_logic;
            annodes: out std_logic_vector(3 downto 0);
            segments: out std_logic_vector(6 downto 0)
           );
end topLevel;

architecture Structural of topLevel is
    --ALU subprograms
    component fullAdder
       Port ( A, B, C : in STD_LOGIC;
           Y, Z : out STD_LOGIC);
    end component fullAdder;
    
    component fourbitAdder
        Port (
            input1 : in std_logic_vector(3 downto 0); 
            input2 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(4 downto 0));
    end component fourbitAdder;
    
    component hammingFunction
         Port (
            input1 : in std_logic_vector(3 downto 0); 
            input2 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0));
    end component hammingFunction;
    
    component isOneGreater
         port(
              input1 : in std_logic_vector(3 downto 0); --first input, it will be the left most on the board
              input2 : in std_logic_vector(3 downto 0); -- second input, give it one switch of space???
              singleOut: out std_logic);
    end component isOneGreater;
    
    component parityCheck
        port(
    input1 : in std_logic_vector(3 downto 0); --first input, it will be the left most on the board
    input2 : in std_logic_vector(3 downto 0); -- second input, give it one switch of space???
    singleOut: out std_logic);
    end component parityCheck;
    
    --display nonsense
    component LEDdisplay
    port(
         clk					: IN  STD_LOGIC;
		 seg0,seg1,seg2,seg3		: IN  STD_LOGIC_VECTOR(6 downto 0);--led display
         seg       		: OUT  STD_LOGIC_VECTOR(6  downto 0);
	     an					: OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component LEDdisplay;
        
        
    component Display_driver
    port(
         inputs : in  STD_LOGIC_VECTOR (3 downto 0);--display driver
         seg_out : out  STD_LOGIC_VECTOR (6 downto 0)
        );    
    end component Display_driver;
   --signal declaration
    signal segment1binary: std_logic_vector(6 downto 0);
    signal segment2binary: std_logic_vector(6 downto 0);
    signal finalBinary: std_logic_vector(4 downto 0);--set outputs to this variable to get displayed
    signal fullAdditionBinary :std_logic_vector(4 downto 0);
    signal hammingFunctionOut: std_logic_vector(3 downto 0);
    signal isOneGreaterOutput: std_logic;--really just a boolean, made it a vector to match other working code
    signal parityOutput: std_logic;
    

begin
--ALU subprograms
    fullAddition: fourbitAdder
        port map(
            input1(3 downto 0) => sw(3 downto 0),
            input2(3 downto 0) => sw(7 downto 4),
            output(4 downto 0) => fullAdditionBinary(4 downto 0)
        );
    Hamming: hammingFunction
        port map(
            input1(3 downto 0) => sw(3 downto 0),
            input2(3 downto 0) => sw(7 downto 4),
            output(3 downto 0) => hammingFunctionOut(3 downto 0)
        );
    greaterFunction: isOneGreater
        port map(
            input1(3 downto 0) => sw(3 downto 0),--led if this number is the largest
            input2(3 downto 0) => sw(7 downto 4),
            singleOut => isOneGreaterOutput
        );
    parityFunction: parityCheck
        port map(
             input1(3 downto 0) => sw(3 downto 0),
            input2(3 downto 0) => sw(7 downto 4),
            singleOut => parityOutput
        );
--display nonsense
    A1: Display_driver
        port map
        (
        inputs(0)=>finalBinary(0),
        inputs(1)=>finalBinary(1),
        inputs(2)=>finalBinary(2),
        inputs(3)=>finalBinary(3),
        seg_out=>segment1binary
        );
    A2: Display_driver
        port map
        (
        inputs(0)=>finalBinary(4),
        inputs(1)=>'0',--values will always be zero. 
        inputs(2)=>'0',
        inputs(3)=>'0',
        seg_out=>segment2binary
        );    
    masterDisplay: LEDdisplay
        port map(
        clk=>clk,
        seg0=>segment1binary,
        seg1=>segment2binary,
        seg2=>"1111111",
        seg3=>"1111111",
        seg=>segments,
        an=>annodes
        );
  process(sw)
    begin
    if sw(15 downto 14) = "00" then--four bit addtion, return 5 bit sum
        finalBinary(4 downto 0) <= fullAdditionBinary(4 downto 0);
        led(15 downto 0)<="0000000000000000";
    elsif sw(15 downto 14)="01" then--is number 1 (closest to right) larger than number 2
        finalBinary(4 downto 0)<="00000";-- for the display
        led(15 downto 1)<="000000000000000";
        led(0)<=isOneGreaterOutput;
    elsif sw(15 downto 14)="10" then-- parity check
        finalBinary(4 downto 0)<="00000";-- for the display
        led(15 downto 1)<="000000000000000";
        led(0)<=isOneGreaterOutput;
    elsif sw(15 downto 14)="11" then--hamming function, LED is on if difference in value at each position
        finalBinary(4 downto 0)<="00000";
        led(11 downto 0) <="000000000000";
        led(15 downto 12) <= hammingFunctionOut;
    end if;
    
  end process;


end architecture Structural;

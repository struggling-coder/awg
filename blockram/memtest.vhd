----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:33 07/12/2017 
-- Design Name: 
-- Module Name:    memtest - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memtest is
    Port ( clk: in STD_LOGIC;
			  datain : in integer;
           enable : in STD_LOGIC;
           status : in STD_LOGIC;
           output : in STD_LOGIC);
end memtest;

architecture basic of memtest is

COMPONENT RAMInterface
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

signal ena, enb: STD_LOGIC;
signal wea: STD_LOGIC_VECTOR(3 downto 0); 
signal addra, addrb, dina, doutb: STD_LOGIC_VECTOR(31 downto 0);

begin

RAM : RAMInterface
  PORT MAP (
    clka => clk,
    ena => ena,
    wea => wea,
    addra => addra,
    dina => dina,
    clkb => clk,
    enb => enb,
    addrb => addrb,
    doutb => doutb
  );

end Behavioral;
